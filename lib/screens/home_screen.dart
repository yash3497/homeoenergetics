import 'package:flutter/material.dart';
import 'package:homeo_energetics/generated/l10n.dart';
import 'package:homeo_energetics/screens/select_analog_screen.dart';
import 'package:homeo_energetics/utils/color_constants.dart';
import 'package:homeo_energetics/utils/subtances_potencies_values.dart';
import 'package:homeo_energetics/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize default data if first time
  _initializeData() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('first_launch') == null) {
      // First time user, save the default data

      await _prefs.setString('first_launch', 'false');
      await _prefs.setString(
          'substances', SubtancesPotenciesValues.substances.toString());
      await _prefs.setString(
          'potencies', SubtancesPotenciesValues.potencies.toString());
    }
  }

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
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset('assets/homeBanner.png'),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                // Wrap the main content with Expanded to make space for spacing
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: RichText(
                            text: TextSpan(
                              text: S.of(context).homeoEnergeticsany,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                              children: [
                                TextSpan(
                                  text: S.of(context).homeopathicg,
                                  style: TextStyle(
                                      color: ColorConstants.primaryGreen),
                                  children: [
                                    TextSpan(
                                      text: S.of(context).lightpower,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22)
                              .copyWith(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).step1,
                                style: TextStyle(
                                    color: ColorConstants.primaryGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                S.of(context).step2,
                                style: TextStyle(
                                    color: ColorConstants.primaryGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                S.of(context).step3,
                                style: TextStyle(
                                    color: ColorConstants.primaryGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                S.of(context).step4,
                                style: TextStyle(
                                    color: ColorConstants.primaryGreen,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            S.of(context).footnote,
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            buttonText: S.of(context).next,
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SelectAnalogScreen()),
                                  (Route<dynamic> route) => false);
                            },
                            backgroundColor: ColorConstants.primaryGreen,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
