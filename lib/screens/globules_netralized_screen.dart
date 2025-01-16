import 'package:flutter/material.dart';
import 'package:homeo_energetics/generated/l10n.dart';
import 'package:homeo_energetics/screens/select_analog_screen.dart';
import 'package:homeo_energetics/utils/color_constants.dart';
import 'package:homeo_energetics/widgets/custom_button.dart';

class GlobulesNetralizedScreen extends StatelessWidget {
  const GlobulesNetralizedScreen({super.key});
  static const routeName = '/globules_netralized';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo.png',
            width: 300,
          ),
        ),
      body: SafeArea(
       bottom: true,
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryGrey,
                ),
                child:  Center(
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                       S.of(context).globulesNeutralized,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CustomButton(
                          buttonText:  S.of(context).restart,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectAnalogScreen()),
                              (route) =>
                                  false, // A condition that determines which routes to remove
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
