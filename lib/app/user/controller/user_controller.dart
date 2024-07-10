import 'package:get/get.dart';
import 'package:whollet_app/app/app.dart';
import 'package:whollet_app/app/user/model/model.dart';

base class UserController extends BaseGetXController with SingletonsMixin {
  final Rxn<UserModel> userModel = Rxn();

  UserController(super.context);

  Future<void> getProfile() async {}

  Future<void> updateProfile(UserModel userModel) async {}

  Future<void> logout() async {
    await _clearUserData();
  }

  Future<void> _clearUserData() async {
    final languageCode = preference.currentLanguageCode;
    final themeMode = preference.themeMode;
    userModel.value = null;
    await preference.clear().whenComplete(
      () {
        preference.currentLanguageCode = languageCode;
        preference.themeMode = themeMode;
      },
    );
  }
}
