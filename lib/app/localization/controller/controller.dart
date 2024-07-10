import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:whollet_app/app/preference/preference.dart';

class LocalizationProvider extends ChangeNotifier {
  LocalizationProvider._internal({
    required this.preference,
    required this.localizationsDelegate,
    required this.selectedLanguage,
  });

  factory LocalizationProvider.fromSystem({
    required LocalizationsDelegate localizationsDelegate,
    required AppPreference preference,
  }) {
    Locale? effectiveLocale;

    final languageCodes = [preference.currentLanguageCode, PlatformDispatcher.instance.locale.languageCode];

    for (var languageCode in languageCodes) {
      final locale = Locale.fromSubtags(languageCode: languageCode);
      if (localizationsDelegate.isSupported(locale)) {
        effectiveLocale = locale;
        break;
      }
    }

    effectiveLocale ??= const Locale('en');

    final selectedLanguage = Language.values.where((element) => element.languageCode == effectiveLocale?.languageCode).firstOrNull;

    return LocalizationProvider._internal(
      localizationsDelegate: localizationsDelegate,
      preference: preference,
      selectedLanguage: selectedLanguage ?? Language.english,
    );
  }

  static LocalizationProvider of(BuildContext context, {bool listen = false}) {
    return Provider.of<LocalizationProvider>(context, listen: listen);
  }

  final AppPreference preference;
  final LocalizationsDelegate localizationsDelegate;
  Language selectedLanguage;

  void updateLanguage(Language language) {
    final locale = Locale.fromSubtags(languageCode: language.languageCode);
    final isSupported = localizationsDelegate.isSupported(locale);
    if (!isSupported) return;
    selectedLanguage = language;
    preference.currentLanguageCode = language.languageCode;
    Get.updateLocale(locale);
    notifyListeners();
  }
}

enum Language {
  english(name: "English", languageCode: "en"),
  hindi(name: "Hindi", languageCode: "hi");

  const Language({required this.name, required this.languageCode});

  final String name;
  final String languageCode;
}
