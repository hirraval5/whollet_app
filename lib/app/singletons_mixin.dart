import 'package:whollet_app/app/environment/environment.dart';
import 'package:whollet_app/utils/firebase_helper.dart';

import 'preference/preference.dart';

mixin SingletonsMixin {
  AppPreference? _preference;
  FirebaseNotificationHelper? _firebaseHelper;
  WholletEnvironment? _environment;

  AppPreference get preference => _preference ??= AppPreference.getInstance();

  FirebaseNotificationHelper get firebaseHelper => _firebaseHelper ??= FirebaseNotificationHelper.getInstance();

  WholletEnvironment get environment => _environment ??= WholletEnvironment.fromArgument();
}
