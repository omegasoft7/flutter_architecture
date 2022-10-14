import 'dart:convert';

import 'package:flutter/foundation.dart';

class Utils {
  static const List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static void printJson(Object? model) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(model);
    debugPrint(prettyprint);
  }

  static void printStackError({
    String? message = "",
    required Object error,
    required StackTrace stackTrace,
  }) {
    debugPrint("$message Caught: $error");
    debugPrint("Stack: $stackTrace");
  }
}

extension FutureT<T> on Future<T> {
  Future<T> printError(String? message) {
    return catchError((error) {
      Utils.printStackError(
          message: message, error: error, stackTrace: StackTrace.current);
    });
  }
}
