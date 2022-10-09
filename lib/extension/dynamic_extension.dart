extension DynamicExtension on dynamic {
  static Map<dynamic, dynamic> cachableTransforms = {};

  R cachableTransform<R>(R Function(dynamic) processor) {
    if (cachableTransforms.containsKey(this)) {
      return cachableTransforms[this];
    }

    final result = processor(this);
    cachableTransforms[this] = result;
    return result;
  }
}
