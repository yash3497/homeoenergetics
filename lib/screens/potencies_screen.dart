import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeo_energetics/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PotenciesScreen extends StatefulWidget {
  const PotenciesScreen({super.key});
  static const routeName = '/potencies';

  @override
  State<PotenciesScreen> createState() => _PotenciesScreenState();
}

class _PotenciesScreenState extends State<PotenciesScreen> {
  // Initialize the fields to empty maps to prevent LateInitializationError
  late Map<String, String> _potencies = {};

  @override
  void initState() {
    super.initState();
    _loadData(); // Load the data asynchronously
  }

  // Fetch saved data from SharedPreferences
  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? savedPotencies = prefs.getString('potencies');

    if (savedPotencies != null) {
      setState(() {
        _potencies = _parseMap(savedPotencies);
      });
    }
  }

  // Parse the string to a Map
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

  // Save data to SharedPreferences
  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('potencies', _potencies.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _potencies.length,
                itemBuilder: (context, index) {
                  String key = _potencies.keys.elementAt(index);
                  String value = _potencies[key] ?? '';
                  return _buildListTile(key, value,);
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                _addNewItem();
              },
              child: Container(
                height: 60,
                color: const Color.fromRGBO(255, 147, 1, 1),
                child:  Center(
                    child: Text(
                  S.of(context).addNewPotencies,
                  style: const TextStyle(fontSize: 18),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Build each ListTile and add swipe-to-delete functionality
 Widget _buildListTile(String key, String value) {
  return Dismissible(
    key: Key(key),
    direction: DismissDirection.endToStart, // Swipe from right to left
    onDismissed: (direction) {
      setState(() {
        _potencies.remove(key);
        _saveData(); // Save data after deletion
      });
    },
    background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Icon(Icons.delete, color: Colors.white),
    ),
    child: Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0), // Adjust padding to reduce space
          title: Text(key, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          subtitle: Text(value),
        ),
        const Divider(
          height: 1.0, // Ensures minimal height for the divider
          thickness: 1.0, // Controls the thickness of the divider
        ), // Adds a horizontal line after the ListTile
      ],
    ),
  );
}


  // Open a dialog to add a new key-value pair
_addNewItem() async {
  TextEditingController keyController = TextEditingController();
  TextEditingController valueController = TextEditingController();

  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title:  Text(S.of(context).addNewPotencies),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10,),
            CupertinoTextField(
              controller: keyController,
              placeholder: S.of(context).enterPotencyName,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              style: const TextStyle(fontSize: 18),
            ),
           const SizedBox(height: 10,),
            CupertinoTextField(
              controller: valueController,
              placeholder: S.of(context).enterPotencySequence,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child:  Text(S.of(context).cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child:  Text(S.of(context).add),
            onPressed: () {
              String newKey = keyController.text;
              String newValue = valueController.text;
              if (newKey.isNotEmpty && newValue.isNotEmpty) {
                setState(() {
                  _potencies[newKey] = newValue;
                  _saveData(); // Save data after adding
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
}
