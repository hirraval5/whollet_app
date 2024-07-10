import 'package:flutter/material.dart';

abstract interface class AppColors extends ThemeExtension<AppColors> {
  /// Start Color Region

  /// End Color Region

  static late AppColors _appColors;

  static set appColor(AppColors value) => _appColors = value;

  factory AppColors.fromTheme(ThemeMode themeMode) {
    _appColors = switch (themeMode) {
      ThemeMode.dark => _DarkColors._internal(),
      _ => _LightColors._internal(),
    };
    return _appColors;
  }

  static AppColors of(BuildContext context) {
    var extension = Theme.of(context).extension<AppColors>();
    assert(extension != null);
    return extension!;
  }

  AppColors._internal();

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return _appColors;
  }

  @override
  ThemeExtension<AppColors> copyWith() {
    return _appColors;
  }
}

final class _LightColors extends AppColors {
  _LightColors._internal() : super._internal();
}

final class _DarkColors extends AppColors {
  _DarkColors._internal() : super._internal();
}

extension AppColorContextExtension on BuildContext {
  AppColors get appColor => AppColors.of(this);
}

extension AppColorThemeExtension on ThemeData {
  AppColors get appColor {
    var extension = this.extension<AppColors>();
    assert(extension != null);
    return extension!;
  }
}
