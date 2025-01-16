import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:homeo_energetics/screens/home_screen.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homeo Energetics',
      home: const HomeScreen(),
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('de', 'DE'), // German
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Added for Cupertino support
        S.delegate, // The generated localization delegate
      ],
      locale: _getDeviceLocale(),
    );
  }

  // Method to detect device language and set the app's locale
  Locale _getDeviceLocale() {
    // Use PlatformDispatcher to get the current device locale
    final locales = PlatformDispatcher.instance.locales;

    // Check the first locale (primary locale) from the device's locale list
    final locale =
        locales.isNotEmpty ? locales.first : const Locale('en', 'US');

    // If the device's primary locale language code is German, return German locale, otherwise return English
    if (locale.languageCode == 'de') {
      return const Locale('de', 'DE');
    } else {
      return const Locale('en', 'US');
    }
  }
}
