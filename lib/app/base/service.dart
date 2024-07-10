import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:whollet_app/app/app.dart';
import 'package:whollet_app/network/network.dart';

base class BaseService with LogMixin, SingletonsMixin {
  final BuildContext context;

  BaseService._internal(this.context);

  factory BaseService(BuildContext context) => BaseService._internal(context);

  Future<T?> processApi<T extends Object?>(BaseApiRequest<T> request) async {
    try {
      final res = await request.fetch();
      return res.data as T?;
    } catch (e) {
      switch (e) {
        case UnauthorizedException():
          preference.clear().whenComplete(() {});
          break;
        case TypeError():
          printError("═══════════════════════════════════ Type Error ═══════════════════════════════════");
          final error = e.toString();
          final errors = error.split("'");
          if (errors.length > 2) {
            printError("Expected [${errors[3]}] but got [${errors[1]}]");
          }
          break;
      }
      return null;
    }
  }
}
