import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:whollet_app/app/routes/routes.dart';

import 'localization/localization.dart';
import 'singletons_mixin.dart';
import 'theme/color.dart';
import 'theme/controller/controller.dart';

export 'extensions/extensions.dart';
export 'localization/localization.dart';
export 'theme/theme.dart';
export 'singletons_mixin.dart';
export 'base/base.dart';

class WholletApp extends StatefulWidget {
  const WholletApp({
    super.key,
    required Bindings Function(BuildContext context) dependency,
  }) : _dependency = dependency;

  final Bindings Function(BuildContext context) _dependency;

  @override
  State<WholletApp> createState() => _WholletAppState();
}

class _WholletAppState extends State<WholletApp> with SingletonsMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocalizationProvider.fromSystem(
            preference: preference,
            localizationsDelegate: WholletLocalization.delegate,
          ),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider.fromSystem(preference: preference)),
      ],
      builder: (context, child) {
        final language = context.select<LocalizationProvider, Language>((value) => value.selectedLanguage);
        final themeMode = context.select<ThemeProvider, ThemeMode>((value) => value.themeMode);
        final appColor = AppColors.fromTheme(themeMode);
        return ScreenUtilInit(
          builder: (context, child) => child!,
          designSize: const Size(375, 812),
          child: GetMaterialApp(
            themeMode: themeMode,
            locale: Locale(language.languageCode),
            initialBinding: widget._dependency.call(context),
            getPages: AppRoutes().pages,
            initialRoute: AppRoutes.dashboard,
            supportedLocales: WholletLocalization.delegate.supportedLocales,
            theme: ThemeData(extensions: [appColor]),
            localizationsDelegates: const [
              WholletLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
          ),
        );
      },
    );
  }
}
