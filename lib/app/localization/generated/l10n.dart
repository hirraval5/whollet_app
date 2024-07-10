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

class ShoppeLocalization {
  ShoppeLocalization();

  static ShoppeLocalization? _current;

  static ShoppeLocalization get current {
    assert(_current != null,
        'No instance of ShoppeLocalization was loaded. Try to initialize the ShoppeLocalization delegate before accessing ShoppeLocalization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<ShoppeLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = ShoppeLocalization();
      ShoppeLocalization._current = instance;

      return instance;
    });
  }

  static ShoppeLocalization of(BuildContext context) {
    final instance = ShoppeLocalization.maybeOf(context);
    assert(instance != null,
        'No instance of ShoppeLocalization present in the widget tree. Did you add ShoppeLocalization.delegate in localizationsDelegates?');
    return instance!;
  }

  static ShoppeLocalization? maybeOf(BuildContext context) {
    return Localizations.of<ShoppeLocalization>(context, ShoppeLocalization);
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<ShoppeLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<ShoppeLocalization> load(Locale locale) =>
      ShoppeLocalization.load(locale);
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
