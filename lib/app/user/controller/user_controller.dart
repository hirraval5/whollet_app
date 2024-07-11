import 'package:get/get.dart';
import 'package:whollet_app/app/app.dart';
import 'package:whollet_app/app/user/model/model.dart';
import 'package:whollet_app/app/user/user.dart';

base class UserController extends BaseGetXController with SingletonsMixin {
  final Rxn<UserModel> userModel = Rxn();

  UserController(super.context);

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  late final _userService = serviceDependencies.userService;

  Future<void> getProfile() async {
    final user = processRequest(_userService.getProfile,onError: (error, stackTrace) {
      print("errror $error");
    },);
    print("user $user");
  }

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
