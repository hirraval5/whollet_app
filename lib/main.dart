import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whollet_app/app/app.dart';
import 'app/preference/preference.dart';
import 'app/user/controller/user_controller.dart';
import 'utils/utils.dart';

void main() {
  _configureApp();
}

Future<void> _configureApp() async {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Get.putAsync<GeneralDependency>(() async => GeneralDependency.getInstance(), permanent: true);
      await Get.find<GeneralDependency>().initDependencies();
      Get.put<ServiceDependency>(ServiceDependency.getInstance(), permanent: true);
      Get.find<ServiceDependency>().initDependencies();
      return runApp(
        const WholletApp(),
      );
    },
    (error, stack) {
      Log.error("ShoppeApp.Error -> $error");
    },
  );
}
