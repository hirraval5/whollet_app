import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:whollet_app/app/user/model/user_authentication.dart';
import 'package:whollet_app/app/user/model/user_model.dart';

final class AppPreference {
  static late final SharedPreferences _preference;

  AppPreference._internal();

  static Future<void> initPreference() async {
    _preference = await SharedPreferences.getInstance();
  }

  static AppPreference? instance;

  factory AppPreference.getInstance() => instance ??= AppPreference._internal();

  bool get isLogin => authentication != null;

  String get currentLanguageCode => _preference.getString("current_language_code") ?? "en";

  set currentLanguageCode(String value) => _preference.setString("current_language_code", value);

  String? get themeMode => _preference.getString("theme_mode");

  set themeMode(String? value) => value == null ? _preference.remove("theme_mode") : _preference.setString("theme_mode", value);

  UserModel? get userModel => _getJsonData("user_model", UserModel.fromJson);

  set userModel(UserModel? value) => value == null ? _preference.remove("user_model") : _setJsonData("user_model", value.toJson());

  UserAuthentication? get authentication => _getJsonData("user_authentication", UserAuthentication.fromJson);

  set authentication(UserAuthentication? value) =>
      value == null ? _preference.remove("user_authentication") : _setJsonData("user_authentication", value.toJson());

  bool get introCompleted => _preference.getBool("intro_completed") ?? false;

  set introCompleted(bool value) => _preference.setBool("intro_completed", value);

  _setJsonData(String key, Map<String, dynamic>? json) {
    if (json == null || json.isEmpty) {
      _preference.remove(key);
      return;
    }
    _preference.setString(key, jsonEncode(json));
  }

  T? _getJsonData<T extends Object>(String key, T Function(Map<String, dynamic> json) parser) {
    if (_preference.containsKey(key)) {
      var value = _preference.get(key);
      if (value is String && value.isNotEmpty) {
        return parser(jsonDecode(value));
      }
    }
    return null;
  }

  Future<bool> clear() {
    var languageCode = currentLanguageCode;
    return _preference.clear().whenComplete(() {
      currentLanguageCode = languageCode;
    });
  }
}
