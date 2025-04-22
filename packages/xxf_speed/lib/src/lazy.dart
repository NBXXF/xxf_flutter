/// 模拟kotlin by lazy 惰性初始化
class Lazy<T> {
  final T Function() _initializer;
  T? _value;

  Lazy(this._initializer);

  T get value {
    _value ??= _initializer();
    return _value!;
  }

  set value(T v) {
    _value = v;
  }

  bool get isInitialized => _value != null;
}
