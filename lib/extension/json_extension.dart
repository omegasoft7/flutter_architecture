import 'package:flutter/foundation.dart';

extension MapJsonExtension on Map<String, Object?>? {
  T getValueOr<T>({
    required String name,
    required T defaultValue,
  }) {
    if (this?.containsKey(name) == true) {
      try {
        if (T == double) {
          return double.parse(this?[name]?.toString() ?? "0.0") as T;
        }
        return this?[name] as T;
      } catch (e) {
        debugPrint(
            "error -> type is: ${T.toString()} name:$name, value:${this?[name]} defaultValue:$defaultValue");
        debugPrint(e.toString());
        return defaultValue;
      }
    } else {
      return defaultValue;
    }
  }

  List<T> getValuesOr<T>({
    required String name,
    required List<T> defaultValue,
  }) {
    if (this?.containsKey(name) == true) {
      // debugPrint("getValueOr value:${this?[name]}");
      return (this?[name] as List<dynamic>).map((e) => e as T).toList();
    } else {
      return defaultValue;
    }
  }
}