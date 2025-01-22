import 'dart:async';
import 'package:flutter/material.dart';
import 'package:homeo_energetics/generated/l10n.dart';
import 'package:homeo_energetics/screens/globules_netralized_screen.dart';
import 'package:homeo_energetics/utils/color_constants.dart';

class ColorSequenceData {
  final String sequence;
  final double share;
  ColorSequenceData(this.sequence, this.share);
}

class CombinedGlobulesScreen extends StatefulWidget {
  const CombinedGlobulesScreen({
    super.key,
    this.sequences,
    required this.isNeutralize,
  });

  final List<ColorSequenceData>? sequences;
  final bool isNeutralize;

  @override
  State<CombinedGlobulesScreen> createState() => _CombinedGlobulesScreenState();
}

class _CombinedGlobulesScreenState extends State<CombinedGlobulesScreen> {
  bool showIllumination = false;
  String currentColor = '0';
  bool isComplete = false;

  final Map<String, Color> colorCodes = {
    '0': const Color.fromRGBO(255, 0, 255, 1),
    '1': const Color.fromRGBO(255, 0, 0, 1),
    '2': const Color.fromRGBO(255, 128, 0, 1),
    '3': const Color.fromRGBO(255, 255, 0, 1),
    '4': const Color.fromRGBO(0, 255, 0, 1),
    '5': const Color.fromRGBO(0, 225, 128, 1),
    '6': const Color.fromRGBO(0, 255, 255, 1),
    '7': const Color.fromRGBO(0, 0, 255, 1),
    '8': const Color.fromRGBO(0, 128, 255, 1),
    '9': const Color.fromRGBO(128, 0, 255, 1),
    'w': const Color.fromRGBO(255, 255, 255, 1),
  };

  void startIllumination() {
    setState(() {
      showIllumination = true;
    });
    if (widget.isNeutralize) {
      _startNeutralizeSequence();
    } else {
      _startColorSequence();
    }
  }

  void _startNeutralizeSequence() async {
    const String neutralizeSequence = '1 w 2 w 3 w 4 w 5 w 6 w 7 w 8 w 9 w 0 w';
    List<String> colors = neutralizeSequence.split(' ');

    for (String color in colors) {
      if (!mounted) return;
      setState(() {
        currentColor = color;
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (mounted) {
      setState(() {
        isComplete = true;
      });
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted && widget.isNeutralize) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const GlobulesNetralizedScreen()),
            (Route<dynamic> route) => false);
      }
    }
  }

  void _startColorSequence() async {
    if (widget.sequences == null) return;

    for (ColorSequenceData data in widget.sequences!) {
      List<String> colors = data.sequence.split(' ');
      int durationMs = (data.share * 1000).round();
      for (String color in colors) {
        if (!mounted) return;
        setState(() {
          currentColor = color;
        });
        await Future.delayed(Duration(milliseconds: durationMs));
      }
    }

    if (mounted) {
      setState(() {
        isComplete = true;
      });
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.primaryGrey,
              ),
              child: Text(
                showIllumination
                    ? S.of(context).illuminatingProcess
                    : S.of(context).step2,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: showIllumination
                        ? colorCodes[currentColor]
                        : Colors.black,
                  ),
                  if (!showIllumination)
                    Positioned(
                      bottom: 30,
                      right: 10,
                      child: GestureDetector(
                        onTap: startIllumination,
                        child: Container(
                          width: 180,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryGreen,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            S.of(context).next,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
