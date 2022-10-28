import 'package:architecture/extension/utils.dart';

extension MapJsonExtension on Map<String, Object?>? {
  T getValueOr<T>({
    required String name,
    required T defaultValue,
  }) {
    if (this?.containsKey(name) == true && this?[name] != null) {
      return _getValueOr(this?[name], defaultValue);
    } else {
      return defaultValue;
    }
  }

  List<T> getListValueOr<T>({
    required String name,
    required T defaultValue,
    required List<T> defaultListValue,
  }) {
    if (this?.containsKey(name) == true && this?[name] != null) {
      try {
        return (this?[name] as List)
            .map((item) => _getValueOr<T>(item, defaultValue))
            .toList();
      } catch (e, stackTrace) {
        Utils.printStackError(
            message:
                "error -> type is: ${T.toString()} name:$name, value:${this?[name]} defaultValue:$defaultValue",
            error: e,
            stackTrace: stackTrace);
        return defaultListValue;
      }
    } else {
      return defaultListValue;
    }
  }
}

T _getValueOr<T>(Object? object, defaultValue) {
  try {
    if (T == double) {
      return double.parse(object?.toString() ?? "0.0") as T;
    } else if (T == List) {
      throw Exception("to fetch a list, use getListValueOr");
    }
    return object as T;
  } catch (e, stackTrace) {
    Utils.printStackError(
        message:
            "error -> type is: ${T.toString()} value:$object defaultValue:$defaultValue",
        error: e,
        stackTrace: stackTrace);
    return defaultValue;
  }
}
