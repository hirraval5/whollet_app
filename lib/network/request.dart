import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'package:http/http.dart' as http;
import 'package:whollet_app/app/app.dart';
import 'dart:io' as io;

import 'error.dart';
import 'print_mixin.dart';
import 'request_type.dart';
import 'response.dart';

typedef ResponseParser<T> = FutureOr<T> Function(dynamic responseData);

T _defaultResponseParser<T>(dynamic responseData) => responseData as T;

abstract class BaseApiRequest<T extends Object?> with LogMixin, SingletonsMixin {
  BaseApiRequest(
    this.type,
    this.path, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    Object? data,
    required ResponseParser<T>? responseParser,
  })  : _queryParams = queryParams,
        _data = data,
        _headers = headers,
        responseParser = responseParser ?? _defaultResponseParser<T>;

  final RequestType type;

  final String path;

  Map<String, String>? _headers;

  Map<String, dynamic>? _queryParams;

  Object? _data;
  ResponseParser<T> responseParser;

  String get _baseUrl => environment.baseUrl;

  set headers(Map<String, String> value) => _headers = value;

  set queryParams(Map<String, dynamic> value) => _queryParams = value;

  set data(Object value) => _data = value;

  http.BaseRequest get _baseRequest;

  Uri get _url {
    return Uri.parse("$_baseUrl$path").replace(queryParameters: _queryParams);
  }

  Map<String, String> get _defaultHeaders {
    return {
      io.HttpHeaders.contentTypeHeader: io.ContentType.json.mimeType,
      if (preference.authentication != null) io.HttpHeaders.authorizationHeader: preference.authentication!.accessToken,
    };
  }

  bool get _logEnabled => environment.isLogEnabled;

  Future<ApiResponse<T>> fetch() async {
    final baseReq = _baseRequest.copyWith(headers: {...?_headers, ..._defaultHeaders});
    _printRequest();
    final req = await baseReq.send().timeout(const Duration(seconds: 5));
    final res = await http.Response.fromStream(req);
    _handleExceptions(res);
    _printResponse(res);
    var data = jsonDecode(res.body);
    return ApiResponse<T>(
      data: await responseParser.call(data),
      response: res,
      statusCode: data?['statusCode'] ?? res.statusCode,
    );
  }

  void _handleExceptions(http.Response res) {
    final data = jsonDecode(res.body);
    final statusCode = data?['statusCode'] ?? res.statusCode;
    if (statusCode == io.HttpStatus.ok || statusCode == io.HttpStatus.created || statusCode == io.HttpStatus.accepted) return;
    final exception = switch (statusCode) {
      io.HttpStatus.unauthorized => UnauthorizedException(message: data?['message'] ?? "Unauthorized"),
      io.HttpStatus.requestTimeout => TimeoutException(message: data?['message'] ?? "Timeout"),
      io.HttpStatus.badRequest || io.HttpStatus.forbidden => ApiResponseException(message: data?['message'] ?? "Bad Request", statusCode: statusCode),
      _ => ApiException(statusCode: statusCode, message: data?['message']),
    };
    _printError(res);
    throw exception;
  }

  void _printRequest() {
    if (!_logEnabled) return;
    printRequest("═══════════════════════════════════ Request Options ═══════════════════════════════════");
    printRequest("Request -> ${type.value} -> $_url");
    printRequest({...?_headers, ..._defaultHeaders}, "Headers");
    if (_queryParams != null) printRequest(_queryParams, "Query Parameters");
    if (_data != null) printRequest(_data, "Data");
  }

  void _printResponse(http.Response res) {
    if (!_logEnabled) return;
    printResponse("═══════════════════════════════════ Response ═══════════════════════════════════");
    printResponse("Response -> [${res.statusCode}] ${type.value} -> $_url");
    var response = jsonDecode(res.body);
    if (response != null) printResponse(response, "Data");
  }

  void _printError(http.Response res) {
    if (!_logEnabled) return;
    printError("═══════════════════════════════════ Error ═══════════════════════════════════");
    printError("Error -> [${res.statusCode}] ${type.value} -> $_url");
    var response = jsonDecode(res.body);
    if (response != null) printError(response, "Data");
  }
}

base class ApiRequest<T> extends BaseApiRequest<T> {
  ApiRequest(
    super.type,
    super.path, {
    super.headers,
    super.queryParams,
    super.data,
    required super.responseParser,
  });

  @override
  BaseRequest get _baseRequest {
    var req = http.Request(type.value, _url);
    if (_data != null) req.body = jsonEncode(_data);
    if (_headers != null) req.headers.addAll(_headers!);
    return req;
  }
}

base class MultipartApiRequest<T> extends BaseApiRequest<T> {
  MultipartApiRequest(
    super.type,
    super.path, {
    super.headers,
    super.queryParams,
    super.data,
    required this.imagePaths,
    required super.responseParser,
  });

  final List<String> imagePaths;

  @override
  http.MultipartRequest get _baseRequest {
    var req = http.MultipartRequest(type.value, _url);
    if (imagePaths.isNotEmpty) req.files.addAll(imagePaths.map((e) => http.MultipartFile.fromString("files", e)));
    if (_headers != null) req.headers.addAll(_headers!);
    if (_data is Map<String, dynamic>) {
      req.fields.addAll((_data as Map).map((key, value) => MapEntry(key.toString(), value.toString())));
    }
    return req;
  }
}
