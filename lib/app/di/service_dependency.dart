import 'package:get/get.dart';

class ServiceDependency extends GetxService {
  ServiceDependency._internal();

  static ServiceDependency? _instance;

  factory ServiceDependency.getInstance() => _instance ??= ServiceDependency._internal();
}
