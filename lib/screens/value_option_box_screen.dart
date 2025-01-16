import 'package:flutter/material.dart';
import 'package:homeo_energetics/generated/l10n.dart';
import 'package:homeo_energetics/screens/potencies_screen.dart';
import 'package:homeo_energetics/screens/substances_screen.dart';

class ValueOptionBoxScreen extends StatelessWidget {
  const ValueOptionBoxScreen({super.key});
  static const routeName = '/value_option_box';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PotenciesScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromRGBO(255, 147, 1, 1),
                child: Center(
                    child: Text(
                  S.of(context).addViewPotencies,
                  style: const TextStyle(fontSize: 18),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SubstancesScreen()),
                );
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color.fromRGBO(255, 254, 0, 1),
                child: Center(
                    child: Text(
                  S.of(context).addViewSubstances,
                  style: const TextStyle(fontSize: 18),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
