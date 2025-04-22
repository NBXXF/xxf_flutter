import 'dart:async';
import 'package:flutter/material.dart';
import 'package:xxf_arch/src/snack_bar/snack_bar_top_level.dart';

typedef ErrorHandler = void Function(Object? error);

///显示异常,一般用toast
ErrorHandler errorHandler = (Object? error) {
  ///默认实现,业务可以复写
  showTopSnackBar(
    backgroundColor: Colors.black,
    content: Text(
      "$error",
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.white),
    ),
  );
};

///提供常用拓展
extension ToastFutureExtensions<T> on Future<T> {
  ///绑定错误信息
  Future<T> bindErrorNotice<E extends Object>({bool Function(E error)? test}) {
    return onError((error, stackTrace) {
      _handleError(error);
      throw error!;
    }, test: test);
  }
}

void _handleError(Object? error) {
  errorHandler(error);
}

extension ToastStreamExtension<T> on Stream<T> {
  Stream<T> bindErrorNotice<E extends Object>({autoUnFocus = true}) {
    return handleError((error, stackTrace) {
      _handleError(error);
      return Stream.error(error, stackTrace);
    });
  }
}
