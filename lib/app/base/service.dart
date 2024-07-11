import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:whollet_app/app/app.dart';
import 'package:whollet_app/network/network.dart';
import 'package:whollet_app/network/request.dart';

base class BaseService with LogMixin {
  final _dio = Get.find<GeneralDependency>().dio;

  Future<T?> processData<T extends Object>(ApiRequest<T> request) async {
    try {
      final res = await request.fetch(_dio);
      return res;
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.cancel:
          throw TimeoutException(message: e.message ?? "");
        case DioExceptionType.badResponse:
          switch (e.response?.statusCode) {
            case HttpStatus.badRequest:
            case HttpStatus.unauthorized:
              throw UnauthorizedException(message: e.message ?? "");
            case HttpStatus.requestTimeout:
              throw TimeoutException(message: e.message ?? "");
            default:
              throw ApiResponseException(
                message: e.message ?? "",
                statusCode: e.response?.statusCode,
                errors: e.response?.data ?? "",
              );
          }
        default:
          throw ApiException(statusCode: e.response?.statusCode, message: e.message);
      }
    }
  }
}
