
extension FutureDoExtensions<T> on Future<T> {
  Future<T> doOnData(void Function(T value) onData) {
    return then((value) {
      onData(value);
      return value;
    });
  }

  Future<T> doOnError(void Function(Object error, StackTrace stackTrace) onError) {
    return catchError((error, stackTrace) {
      onError(error, stackTrace);
      /// 继续抛出错误以保持链式调用
      return Future.error(error, stackTrace);
    });
  }

  Future<T> doOnDone(void Function() onDone) {
    return whenComplete(() {
      onDone();
    });
  }
}
