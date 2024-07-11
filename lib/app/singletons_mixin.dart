import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:whollet_app/app/app.dart';
import 'package:whollet_app/app/environment/environment.dart';
import 'package:whollet_app/app/preference/preference.dart';
import 'package:whollet_app/utils/utils.dart';

mixin SingletonsMixin {
  final _dependency = Get.find<GeneralDependency>();

  AppPreference get preference => _dependency.preference;

  FirebaseNotificationHelper get firebaseHelper => _dependency.firebaseNotificationHelper;

  WholletEnvironment get environment => _dependency.wholletEnvironment;

  Dio get dio => _dependency.dio;
}
