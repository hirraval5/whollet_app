import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whollet_app/app/app.dart';
import 'package:whollet_app/utils/utils.dart';

typedef LoadingCallback = void Function(bool loading);
typedef ErrorCallback = void Function(Object? error, StackTrace stackTrace);

void _defaultErrorHandler(Object? error, StackTrace stackTrace) {
  Log.debug(error);
}

base class BaseGetXController extends GetxController with SingletonsMixin {
  final BuildContext context;

  BaseGetXController(this.context);

  Future<T?> processRequest<T extends Object?>(
    Future<T?> Function() request, {
    LoadingCallback? onLoading,
    ErrorCallback? onError = _defaultErrorHandler,
  }) async {
    onLoading?.call(true);
    final result = await request().onError((error, stackTrace) {
      if (error != null) {
        onError?.call(error, stackTrace);
      }
      return null;
    });
    onLoading?.call(false);
    return result;
  }
}
