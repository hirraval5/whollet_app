import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whollet_app/app/environment/environment.dart';
import 'package:whollet_app/app/preference/preference.dart';
import 'package:whollet_app/utils/firebase_helper.dart';

class GeneralDependency extends GetxService {
  GeneralDependency._internal();

  static GeneralDependency? _instance;

  factory GeneralDependency.getInstance() => _instance ??= GeneralDependency._internal();

  late AppPreference _preference;
  late FirebaseNotificationHelper _notificationHelper;
  late Dio _dio;
  late WholletEnvironment _environment;

  AppPreference get preference => _preference;

  FirebaseNotificationHelper get firebaseNotificationHelper => _notificationHelper;

  WholletEnvironment get wholletEnvironment => _environment;

  Dio get dio => _dio;

  Future<void> initDependencies() async {
    _preference = await _providesAppPreference();
    _notificationHelper = _providesFirebase();
    _environment = _providesEnvironment();
    _dio = _providesDio(preference: _preference, environment: _environment);
  }

  Future<AppPreference> _providesAppPreference() async {
    return SharedPreferences.getInstance().then(AppPreference.new);
  }

  FirebaseNotificationHelper _providesFirebase() => FirebaseNotificationHelper.getInstance();

  WholletEnvironment _providesEnvironment() => WholletEnvironment.fromArgument();

  Dio _providesDio({required AppPreference preference, required WholletEnvironment environment}) {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: environment.baseApi,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      headers: {
        HttpHeaders.acceptHeader: Headers.jsonContentType,
        HttpHeaders.contentTypeHeader: Headers.jsonContentType,
      },
    );

    final dio = Dio(baseOptions);
    return dio;
  }
}
