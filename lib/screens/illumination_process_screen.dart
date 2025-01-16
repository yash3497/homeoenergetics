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

class IlluminationProcessScreen extends StatefulWidget {
  const IlluminationProcessScreen({
    super.key,
    this.sequences,
    this.isNeutralize = false,
  });

  final List<ColorSequenceData>? sequences; // Optional normal sequences
  final bool isNeutralize; // Flag to identify if it's neutralize mode

  @override
  State<IlluminationProcessScreen> createState() =>
      _IlluminationProcessScreenState();
}

class _IlluminationProcessScreenState extends State<IlluminationProcessScreen> {
  String currentColor = '0';
  bool isComplete = false;

  // Define color mapping with 'w' for white
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

  @override
  void initState() {
    super.initState();
    if (widget.isNeutralize == true) {
      _startNeutralizeSequence();
    } else {
      _startColorSequence();
    }
  }

  void _startNeutralizeSequence() async {
    // Predefined neutralize sequence
    const String neutralizeSequence = '1 w 2 w 3 w 4 w 5 w 6 w 7 w 8 w 9 w 0 w';
    List<String> colors = neutralizeSequence.split(' ');

    // Show each color in the neutralize sequence
    for (String color in colors) {
      if (!mounted) return;

      setState(() {
        currentColor = color;
      });

      // Fixed duration for neutralize sequence (e.g., 500ms per color)
      await Future.delayed(const Duration(milliseconds: 500));
    }

    // After sequence completion
    if (mounted) {
      setState(() {
        isComplete = true;
      });

      await Future.delayed(const Duration(milliseconds: 100));

      if (mounted) {
        if (widget.isNeutralize == true) {
          // Navigate to the specified route
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const GlobulesNetralizedScreen()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.pop(context);
        }
      }
    }
  }

  void _startColorSequence() async {
    if (widget.sequences == null) return;
    print(widget.sequences!.map((e) => e.sequence).join(' '));
    // Process each sequence
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

      await Future.delayed(const Duration(milliseconds: 100));

      if (mounted) {
        Navigator.pop(context);
      }
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
            // Header section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstants.primaryGrey,
              ),
              child: Text(
                S.of(context).illuminatingProcess,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            // Main content section (random color background for 50 seconds)
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: colorCodes[currentColor], // Set random color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
