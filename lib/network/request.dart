import 'dart:async';

import 'package:dio/dio.dart';
import 'package:whollet_app/network/network.dart';

class ApiRequest<T extends Object?> {
  ApiRequest(this.path, this.requestType);

  final String path;
  final RequestType requestType;

  Object? _data;
  Map<String, dynamic>? _queryParams;
  Map<String, dynamic>? _headers;

  set data(Object value) => _data = value;

  set queryParams(Map<String, dynamic> value) => _queryParams = value;

  set headers(Map<String, dynamic> value) => _headers = value;

  FutureOr<T?> fetch(Dio dio, {String? baseUrl}) async {
    final result = await dio.fetch<T>(_setStreamType(Options(method: requestType.name, headers: _headers)
        .compose(dio.options, path, queryParameters: _queryParams, data: _data)
        .copyWith(baseUrl: baseUrl ?? dio.options.baseUrl)));
    return result.data;
  }

  RequestOptions _setStreamType(RequestOptions requestOptions) {
    if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      requestOptions.responseType = ResponseType.json;
    }
    return requestOptions;
  }
}
