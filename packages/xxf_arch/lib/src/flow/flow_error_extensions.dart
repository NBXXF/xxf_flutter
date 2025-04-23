import 'dart:async';
import 'package:xxf_arch/src/toast/toast_utils.dart';
import 'package:xxf_flow/xxf_flow.dart';

typedef ErrorHandler = void Function(Object? error);

///显示异常,一般用toast
ErrorHandler errorHandler = (Object? error) {
  ///默认实现,业务可以复写
  ToastUtils.showToast("$error");
};

///提供常用拓展
extension ToastFutureExtensions<T> on Future<T> {
  ///绑定错误信息,自动提示
  Future<T> bindErrorNotice() {
    return doOnError((error, stackTrace) {
      _handleError(error);
    });
  }
}

void _handleError(Object? error) {
  errorHandler(error);
}

extension ToastStreamExtension<T> on Stream<T> {
  ///绑定错误信息,自动提示
  Stream<T> bindErrorNotice() {
    return doOnError((error, stackTrace) {
      _handleError(error);
    });
  }
}
