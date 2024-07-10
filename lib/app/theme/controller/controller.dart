import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whollet_app/app/preference/preference.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;

  factory ThemeProvider.fromSystem({
    ThemeMode? themeMode,
    required AppPreference preference,
  }) {
    final theme = preference.themeMode;
    final ThemeMode themeMode = theme != null
        ? ThemeMode.values.byName(theme)
        : switch (PlatformDispatcher.instance.platformBrightness) {
            Brightness.light => ThemeMode.light,
            Brightness.dark => ThemeMode.dark,
          };
    return ThemeProvider._internal(
      preference: preference,
      themeMode: themeMode,
    );
  }

  static ThemeProvider of(BuildContext context, {bool listen = false}) {
    return Provider.of<ThemeProvider>(context, listen: listen);
  }

  final AppPreference preference;

  ThemeProvider._internal({
    required this.preference,
    required this.themeMode,
  });

  void updateTheme(ThemeMode themeMode) {
    this.themeMode = themeMode;
    preference.themeMode = themeMode.name;
    notifyListeners();
  }
}
