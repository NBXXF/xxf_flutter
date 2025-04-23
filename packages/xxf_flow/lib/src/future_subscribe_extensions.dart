import 'dart:async';

import 'package:async/async.dart';
import 'package:xxf_flow/src/future_convert_extensions.dart';
import 'package:xxf_flow/src/future_do_extensions.dart';

extension FutureSubscribeExtensions<T> on Future<T> {
  ///跟stream 方法对齐
  CancelableOperation<T> listen({
    required void Function(T data) onData,
    Function(Object error, StackTrace stack)? onError,
    void Function()? onDone,
  }) {
    return doOnData((value) {
          onData(value);
        })
        .catchError((error, stack) {
          if (onError != null) {
            onError(error, stack);
          }
        })
        .whenComplete(() {
          onDone?.call();
        })
        .toCancelable();
  }
}
