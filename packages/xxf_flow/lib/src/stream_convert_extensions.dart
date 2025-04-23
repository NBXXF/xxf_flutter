import 'package:async/async.dart';

extension StreamConvertExtensions<T> on Stream<T> {
  Future<T> firstOrDefault(T defaultValue) {
    return firstOrNull.then((value) {
      return value ?? defaultValue;
    });
  }

  Future<T?> get lastOrNull async {
    try {
      return await last;
    } catch (e) {
      if (e is StateError) {
        /// Stream 是空的
        return null;
      } else {
        rethrow;

        /// 其他异常继续抛出
      }
    }
  }

  Future<T> lastOrDefault(T defaultValue) async {
    return lastOrNull.then((value) {
      return value ?? defaultValue;
    });
  }
}
