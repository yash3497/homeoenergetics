import 'package:flutter/material.dart';
import 'package:homeo_energetics/generated/l10n.dart';
import 'package:homeo_energetics/screens/illumination_process_screen.dart';
import 'package:homeo_energetics/utils/color_constants.dart';
import 'package:homeo_energetics/widgets/custom_button.dart';

class PlaceGlobulesScreen extends StatelessWidget {
  const PlaceGlobulesScreen({
    super.key,
    this.sequences,
    required this.isNeutralize,
  });

  final List<ColorSequenceData>? sequences; // Optional normal sequences
  final bool isNeutralize; // Flag to identify if it's neutralize mode

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
                S.of(context).step2,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ),
            // Main content section (with black container and bottom-right section)
            Expanded(
              child: Stack(
                children: [
                  // Black container that takes up the full screen height
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black,
                  ),
                  // Small bottom right section
                  Positioned(
                    bottom: 30, // Distance from the bottom of the screen
                    right: 10, // Distance from the right side of the screen
                    child: CustomButton(
                      buttonText: S.of(context).next,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IlluminationProcessScreen(
                                    isNeutralize: isNeutralize,
                                    sequences: sequences,
                                  )),
                        );
                      },
                      backgroundColor: ColorConstants.primaryGreen,
                      textColor: Colors.white,
                      textSize: 20,
                      buttonWidth: 180,
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
