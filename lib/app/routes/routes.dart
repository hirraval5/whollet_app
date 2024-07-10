import 'package:flutter/material.dart';
import 'package:get/get.dart';

base class AppRoutes {
  /* Authentication Routes */
  static const login = '/login';
  static const register = '/register';
  static const forgetPassword = '/forget_password';
  static const verifyOtp = '/verify_otp';

  /* Dashboard Routes */
  static const dashboard = '/dashboard';

  factory AppRoutes() => AppRoutes._();

  AppRoutes._();

  List<GetPage> get pages => [
        GetPage(
          name: dashboard,
          page: () => Container(),
        ),
        GetPage(
          name: login,
          page: () => Container(),
        ),
      ];
}
