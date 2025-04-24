extension AssociatedObjectExtensions on Object {
  /// static 使得所有对象共享一个 Expando 实例
  static final _associatedObject = Expando<Map<String, dynamic>>();

  /// 设置关联对象
  void setAssociatedObject(String key, dynamic value) {
    /// 获取当前对象的关联对象缓存，如果没有，则创建一个空的 Map
    final cache = _associatedObject[this] ??= <String, dynamic>{};
    cache[key] = value;
  }

  /// 获取关联对象
  T? getAssociatedObject<T>(String key) {
    final cache = _associatedObject[this];
    return cache != null ? cache[key] as T? : null;
  }

  /// 获取非空关联对象
  T getAssociatedObjectOrDefault<T>(String key, T defaultValue) {
    return getAssociatedObject<T>(key) ?? defaultValue;
  }

  /// 清除关联对象
  void clearAssociatedObject() {
    _associatedObject[this] = null;

    /// 设置为 null，避免无效的 Map 被长期存在
  }
}
