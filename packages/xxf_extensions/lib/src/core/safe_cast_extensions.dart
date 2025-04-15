///类型安全转换
extension SafeCastExtensions on Object? {
  T? asType<T>() => this is T ? this as T : null;
}
