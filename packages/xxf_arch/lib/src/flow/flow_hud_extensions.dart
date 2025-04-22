void _showLoading() {}

void _dismissLoading() {}

extension HudFutureExtension<T> on Future<T> {
  Future<T> onLoading({int? milliseconds, int? seconds}) {
    _showLoading();
    if (milliseconds != null || seconds != null) {
      return timeout(
        Duration(milliseconds: milliseconds ?? 0, seconds: seconds ?? 0),
      ).whenComplete(() => _dismissLoading());
    } else {
      return whenComplete(() => _dismissLoading());
    }
  }
}

extension HudStreamExtension<T> on Stream<T> {
  Stream<T> onLoading() {
    _showLoading();
    return map((value) {
      _dismissLoading();
      return value;
    }).handleError((error, stackTrace) {
      _dismissLoading();
      return Stream.error(error, stackTrace);
    });
  }
}
