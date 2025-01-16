// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `With HomeoEnergetics, you can make almost any `
  String get homeoEnergeticsany {
    return Intl.message(
      'With HomeoEnergetics, you can make almost any ',
      name: 'homeoEnergeticsany',
      desc: '',
      args: [],
    );
  }

  /// `Analog Homeopathic* `
  String get homeopathicg {
    return Intl.message(
      'Analog Homeopathic* ',
      name: 'homeopathicg',
      desc: '',
      args: [],
    );
  }

  /// `by the power of light: `
  String get lightpower {
    return Intl.message(
      'by the power of light: ',
      name: 'lightpower',
      desc: '',
      args: [],
    );
  }

  /// `1. Select homeopathic`
  String get step1 {
    return Intl.message(
      '1. Select homeopathic',
      name: 'step1',
      desc: '',
      args: [],
    );
  }

  /// `2. Place globules on screen`
  String get step2 {
    return Intl.message(
      '2. Place globules on screen',
      name: 'step2',
      desc: '',
      args: [],
    );
  }

  /// `3. Start illumination process`
  String get step3 {
    return Intl.message(
      '3. Start illumination process',
      name: 'step3',
      desc: '',
      args: [],
    );
  }

  /// `4. Analog homeopathic ready`
  String get step4 {
    return Intl.message(
      '4. Analog homeopathic ready',
      name: 'step4',
      desc: '',
      args: [],
    );
  }

  /// `*In analog homeopathics, the dynamization of the carrier substance does not take place through dilution and shaking, but through the power of light (patent pending). From a scientific point of view, classical homeopathy and analog homeopathics work due to the placebo effect.`
  String get footnote {
    return Intl.message(
      '*In analog homeopathics, the dynamization of the carrier substance does not take place through dilution and shaking, but through the power of light (patent pending). From a scientific point of view, classical homeopathy and analog homeopathics work due to the placebo effect.',
      name: 'footnote',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `1. Select analog homeopathic`
  String get selectAnalogHomeopathic {
    return Intl.message(
      '1. Select analog homeopathic',
      name: 'selectAnalogHomeopathic',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Substance`
  String get substance {
    return Intl.message(
      'Substance',
      name: 'substance',
      desc: '',
      args: [],
    );
  }

  /// `Potency`
  String get potency {
    return Intl.message(
      'Potency',
      name: 'potency',
      desc: '',
      args: [],
    );
  }

  /// `Attention: The sum of the shares must be 100%! Ok`
  String get attention {
    return Intl.message(
      'Attention: The sum of the shares must be 100%! Ok',
      name: 'attention',
      desc: '',
      args: [],
    );
  }

  /// `Sum`
  String get sum {
    return Intl.message(
      'Sum',
      name: 'sum',
      desc: '',
      args: [],
    );
  }

  /// `Neutralize`
  String get neutralize {
    return Intl.message(
      'Neutralize',
      name: 'neutralize',
      desc: '',
      args: [],
    );
  }

  /// `Illumination process - please wait`
  String get illuminatingProcess {
    return Intl.message(
      'Illumination process - please wait',
      name: 'illuminatingProcess',
      desc: '',
      args: [],
    );
  }

  /// `analog homeopathic ready`
  String get analogHomeopathicReady {
    return Intl.message(
      'analog homeopathic ready',
      name: 'analogHomeopathicReady',
      desc: '',
      args: [],
    );
  }

  /// `Restart`
  String get restart {
    return Intl.message(
      'Restart',
      name: 'restart',
      desc: '',
      args: [],
    );
  }

  /// `4. Globules neutralized, they can be re-dynamized.`
  String get globulesNeutralized {
    return Intl.message(
      '4. Globules neutralized, they can be re-dynamized.',
      name: 'globulesNeutralized',
      desc: '',
      args: [],
    );
  }

  /// `Add/View Potencies`
  String get addViewPotencies {
    return Intl.message(
      'Add/View Potencies',
      name: 'addViewPotencies',
      desc: '',
      args: [],
    );
  }

  /// `Add/View Substances`
  String get addViewSubstances {
    return Intl.message(
      'Add/View Substances',
      name: 'addViewSubstances',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Add New Potencies`
  String get addNewPotencies {
    return Intl.message(
      'Add New Potencies',
      name: 'addNewPotencies',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add potency details`
  String get addPotencyDetails {
    return Intl.message(
      'Add potency details',
      name: 'addPotencyDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter potency name`
  String get enterPotencyName {
    return Intl.message(
      'Enter potency name',
      name: 'enterPotencyName',
      desc: '',
      args: [],
    );
  }

  /// `Enter potency sequence`
  String get enterPotencySequence {
    return Intl.message(
      'Enter potency sequence',
      name: 'enterPotencySequence',
      desc: '',
      args: [],
    );
  }

  /// `Add new substances`
  String get addNewSubstances {
    return Intl.message(
      'Add new substances',
      name: 'addNewSubstances',
      desc: '',
      args: [],
    );
  }

  /// `Enter substance details`
  String get enterSubstanceDetails {
    return Intl.message(
      'Enter substance details',
      name: 'enterSubstanceDetails',
      desc: '',
      args: [],
    );
  }

  /// `Enter substance name`
  String get enterSubstanceName {
    return Intl.message(
      'Enter substance name',
      name: 'enterSubstanceName',
      desc: '',
      args: [],
    );
  }

  /// `Enter substance sequence`
  String get enterSubstanceSequence {
    return Intl.message(
      'Enter substance sequence',
      name: 'enterSubstanceSequence',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
