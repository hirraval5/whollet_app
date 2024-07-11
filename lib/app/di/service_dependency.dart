import 'package:get/get.dart';
import 'package:whollet_app/app/user/service/user_service.dart';

class ServiceDependency extends GetxService {
  ServiceDependency._internal();

  static ServiceDependency? _instance;

  factory ServiceDependency.getInstance() => _instance ??= ServiceDependency._internal();

  late UserService _userService;

  UserService get userService => _userService;

  void initDependencies() {
    _userService = UserService();
  }
}
