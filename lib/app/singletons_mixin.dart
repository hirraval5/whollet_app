import 'preference/preference.dart';

mixin SingletonsMixin {
  AppPreference get preference => AppPreference.getInstance();

  // FirebaseNotificationHelper get firebaseHelper => FirebaseNotificationHelper.getInstance();
}
