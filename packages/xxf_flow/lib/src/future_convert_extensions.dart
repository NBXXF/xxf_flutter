import 'dart:async';

import 'package:async/async.dart';

extension FutureConvertExtensions<T> on Future<T> {
  CancelableOperation<T> asCancelable({FutureOr Function()? onCancel}) {
    return CancelableOperation.fromFuture(this, onCancel: onCancel);
  }

  CancelableOperation<T> toCancelable({FutureOr Function()? onCancel}) {
    return asCancelable(onCancel: onCancel);
  }

  Stream<T> toStream() {
    return asStream();
  }
}
