import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const jsonEncoder = JsonEncoder.withIndent('  ');

const _ansiEsc = '\x1B[';
const _ansiDefault = '${_ansiEsc}0m';

mixin LogMixin {
  void printRequest(Object? value, [String prefix = ""]) => _print(value, 208, prefix);

  void printError(Object? value, [String prefix = ""]) => _print(value, 196, prefix);

  void printResponse(Object? value, [String prefix = ""]) => _print(value, 77, prefix);

  void _print(Object? object, int foregroundColor, String prefix) {
    String content;
    if (object is Map || object is List) {
      content = jsonEncoder.convert(object);
    } else {
      content = object.toString();
    }
    if (prefix.isNotEmpty) content = "$prefix: $content";
    if (object is Map || object is List) {
      content = content.replaceAll(_ansiEsc, '').replaceAll(_ansiDefault, '');
      debugPrint("${_ansiEsc}38;5;${foregroundColor}m$content$_ansiDefault");
    } else {
      debugPrint("${_ansiEsc}38;5;${foregroundColor}m$content$_ansiDefault");
    }
  }
}
