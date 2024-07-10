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

void _configureApp() {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await AppPreference.initPreference();
      return runApp(
        WholletApp(
          dependency: (context) => _GeneralDependencyBinding(context),
        ),
      );
    },
    (error, stack) {
      Log.error("ShoppeApp.Error -> $error");
    },
  );
}

class _GeneralDependencyBinding extends Bindings {
  final BuildContext context;

  _GeneralDependencyBinding(this.context);

  @override
  void dependencies() {
    Get.put(UserController(context), permanent: true);
  }
}
