import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homeo_energetics/generated/l10n.dart';
import 'package:homeo_energetics/screens/combained_globules_screen.dart';
// import 'package:homeo_energetics/screens/illumination_process_screen.dart';
import 'package:homeo_energetics/screens/value_option_box_screen.dart';
import 'package:homeo_energetics/utils/color_constants.dart';
import 'package:homeo_energetics/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectAnalogScreen extends StatefulWidget {
  const SelectAnalogScreen({super.key});

  @override
  State<SelectAnalogScreen> createState() => _SelectAnalogScreenState();
}

class _SelectAnalogScreenState extends State<SelectAnalogScreen> {
  late SharedPreferences _prefs;

  // For substances and potencies fetched from SharedPreferences
  late Map<String, String> _substances;
  late Map<String, String> _potencies;

  // For dropdowns
  List<String> substanceOptions = []; // Initialize with an empty list
  List<String> potencyOptions = []; // Initialize with an empty list
  List<String?>? selectedSubstance;
  List<String?>? selectedPotency;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // Initialize substances and potencies from SharedPreferences
  Future<void> _initializeData() async {
    _prefs = await SharedPreferences.getInstance();

    // Fetch substances and potencies from local storage
    String? savedSubstances = _prefs.getString('substances');
    String? savedPotencies = _prefs.getString('potencies');

    setState(() {
      if (savedSubstances != null) {
        _substances = _parseMap(savedSubstances);
        substanceOptions = _substances.keys.toList();
      } else {
        _substances = {};
        substanceOptions = [];
      }

      if (savedPotencies != null) {
        _potencies = _parseMap(savedPotencies);
        potencyOptions = _potencies.keys.toList();
      } else {
        _potencies = {};
        potencyOptions = [];
      }

      // Initialize selectedSubstance and selectedPotency with null values for each row
      selectedSubstance = List.generate(8, (_) => null);
      selectedPotency = List.generate(8, (_) => null);
    });
  }

  // Parse map from saved data (string format from SharedPreferences)
  Map<String, String> _parseMap(String savedData) {
    final Map<String, String> parsedMap = {};
    savedData.replaceAll(RegExp(r'[{}]'), '').split(',').forEach((pair) {
      final parts = pair.split(':');
      if (parts.length == 2) {
        parsedMap[parts[0].trim()] = parts[1].trim();
      }
    });
    return parsedMap;
  }

  String calculateEnlightenmentSequence() {
    List<String> sequences = [];

    for (int i = 0; i < 8; i++) {
      if (_percentageControllers[i].text.isNotEmpty &&
          selectedSubstance?[i] != null &&
          selectedPotency?[i] != null) {
        // Get substance frequency and potency signal
        String substanceFreq = _substances[selectedSubstance![i]] ?? '';
        String potencySignal = _potencies[selectedPotency![i]] ?? '';

        // Combine them
        String sequence = '$potencySignal$substanceFreq';
        sequences.add(sequence);
      }
    }

    // Combine all sequences
    return sequences.join('');
  }

  bool validateInputs() {
    double total = 0;
    bool allFieldsFilled = true;

    for (int i = 0; i < 8; i++) {
      if (_percentageControllers[i].text.isNotEmpty) {
        double? value = double.tryParse(_percentageControllers[i].text);
        if (value != null) {
          total += value;

          // Check if corresponding substance and potency are selected
          if (selectedSubstance?[i] == null || selectedPotency?[i] == null) {
            allFieldsFilled = false;
          }
        }
      }
    }

    return total == 100 && allFieldsFilled;
  }

  final List<TextEditingController> _percentageControllers = List.generate(
    8,
    (_) => TextEditingController(),
  );

  double totalPercentage = 0;
  int _clickCount = 0;
  Timer? _resetTimer;

  void _updateTotalPercentage() {
    setState(() {
      totalPercentage = _percentageControllers.fold(
        0,
        (sum, controller) {
          final value = double.tryParse(controller.text) ?? 0;
          return sum + value;
        },
      );
    });
  }

  void _onTap() {
    // Reset the timer on each click
    _resetTimer?.cancel(); // Cancel any existing timer
    _startResetTimer(); // Start a new timer

    setState(() {
      _clickCount++;
    });

    if (_clickCount >= 5) {
      // Navigate to the second screen after 25 clicks
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ValueOptionBoxScreen()),
      ).then((_) {
        // Reset the counter when the user returns
        setState(() {
          _clickCount = 0;
        });
      });
    }
  }

  void _startResetTimer() {
    // Start a timer that resets the click count after 5 seconds
    _resetTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _clickCount = 0;
      });
    });
  }

  @override
  void dispose() {
    for (final controller in _percentageControllers) {
      controller.dispose();
    }
    _resetTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus any focused input field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.white,
          title: GestureDetector(
            onTap: _onTap,
            child: Image.asset(
              'assets/logo.png',
              width: 300,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryGrey,
                ),
                child: Text(
                  S.of(context).selectAnalogHomeopathic,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(left: 50, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).share,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
                    Text(S.of(context).substance,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
                    Text(S.of(context).potency,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 8, // Number of rows
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Row Number
                          Container(
                            width: 35,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryGreen,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),

                          // Share Input (Editable Percentage)
                          Container(
                            width: 60,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstants.lightGrey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _percentageControllers[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.left,
                                    cursorColor: ColorConstants.primaryGreen,
                                    // Align text to the right
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 12,
                                          bottom: 5), // Padding for alignment
                                    ),
                                    onChanged: (value) {
                                      _updateTotalPercentage();
                                    },
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                      right: 4), // Spacing for the % symbol
                                  child: Text(
                                    '%',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Substance Placeholder
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                // Show the selection dialog for Substance
                                final selectedValue = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Scrollbar(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: substanceOptions.map(
                                                  (option) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).pop(
                                                            option); // Return the selected option
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 12.0),
                                                        child: Text(
                                                          option,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );

                                if (selectedValue != null) {
                                  setState(() {
                                    selectedSubstance![index] =
                                        selectedValue; // Update the selected value at the correct index
                                  });
                                }
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: ColorConstants.lightGrey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  selectedSubstance?[index] ??
                                      '-', // Null-safe check
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Potency Selection
                          Container(
                            width: 60,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstants.lightGrey,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButton<String>(
                              value: selectedPotency?[index], // Null-safe check
                              hint: const Text(
                                '-',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              underline: const SizedBox(), // Removes underline
                              isExpanded: false,
                              icon: const SizedBox
                                  .shrink(), // Hides the dropdown icon
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedPotency?[index] = newValue!;
                                });
                              },
                              dropdownColor: Colors.white,
                              itemHeight: 48,
                              items: potencyOptions
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewInsets.bottom > 0 ? 10 : 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).sum,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    if (totalPercentage != 0)
                      RichText(
                          text: TextSpan(
                              text: ': ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                            TextSpan(
                              text: '${totalPercentage.toStringAsFixed(2)}%',
                              style: TextStyle(
                                color: totalPercentage == 100
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            )
                          ]))
                    // Text(
                    //   ': ${totalPercentage.toStringAsFixed(2)}%',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     color: totalPercentage == 100 ? Colors.green : Colors.red,
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(
                    bottom:
                        MediaQuery.of(context).viewInsets.bottom > 0 ? 10 : 0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        buttonText: S.of(context).neutralize,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CombinedGlobulesScreen(
                                      isNeutralize: true,
                                    )),
                          );
                        },
                        backgroundColor: ColorConstants.primaryGrey,
                        textColor: Colors.black,
                        textSize: 20,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        buttonText: S.of(context).next,
                        onPressed: () {
                          if (!validateInputs()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Attention: The sum of the shares must be 100% with and all fields are filled'),
                              ),
                            );
                            return;
                          }

                          // Collect sequences and their shares
                          List<ColorSequenceData> sequences = [];

                          for (int i = 0; i < 8; i++) {
                            if (_percentageControllers[i].text.isNotEmpty &&
                                selectedSubstance?[i] != null &&
                                selectedPotency?[i] != null) {
                              // Get substance frequency and potency signal
                              String substanceFreq =
                                  _substances[selectedSubstance![i]] ?? '';
                              String potencySignal =
                                  _potencies[selectedPotency![i]] ?? '';

                              // Combine them for this row's sequence
                              String sequence = '$potencySignal $substanceFreq';
                              double share =
                                  double.parse(_percentageControllers[i].text) /
                                      100; // Convert percentage to decimal

                              sequences.add(ColorSequenceData(sequence, share));
                            }
                          }
                        
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CombinedGlobulesScreen(
                                sequences: sequences,
                                isNeutralize: false,
                              ),
                            ),
                          );
                        },
                        backgroundColor: ColorConstants.primaryGreen,
                        textColor: Colors.white,
                        textSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
