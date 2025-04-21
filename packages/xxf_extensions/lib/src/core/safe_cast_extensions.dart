///类型安全转换
extension SafeCastExtensions on Object? {
  T? asType<T>() => this is T ? this as T : null;

  T asTypeOrDefault<T>(T Function() createFactory) =>
      this is T ? (this as T) : createFactory();
}
