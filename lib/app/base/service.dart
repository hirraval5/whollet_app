import 'dart:io' as io;

import 'package:whollet_app/network/network.dart';

abstract class BaseService with LogMixin {
  Future<T?> processApi<T extends Object?>(BaseApiRequest<T> request) async {
    try {
      final res = await request.fetch();
      return res.data;
    } catch (e) {
      switch (e) {
        case UnauthorizedException():
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
