import 'package:whollet_app/app/app.dart';
import 'package:whollet_app/app/user/model/user_model.dart';
import 'package:whollet_app/network/network.dart';
import 'package:whollet_app/network/request.dart';

base class UserService extends BaseService {
  Future<UserModel?> getProfile() async {
    final request = ApiRequest<UserModel>("user/get", RequestType.get)
      ..data = {}
      ..queryParams = {}
      ..headers = {};
    return processData(request);
  }
}
