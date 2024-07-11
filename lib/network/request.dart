import 'package:dio/dio.dart';
import 'package:whollet_app/network/network.dart';

class ApiRequest<T extends Object?> {
  ApiRequest(this.path, this.requestType);

  final String path;
  final RequestType requestType;

  Map<String, dynamic>? data;
  Map<String, dynamic>? queryParams;
  Map<String, dynamic>? headers;
}
