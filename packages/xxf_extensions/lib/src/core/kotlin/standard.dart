/// 同步作用域函数扩展（非空类型）
extension KotlinSyncScope<T extends Object> on T {
  /// let: 转换对象并返回结果
  R let<R>(R Function(T) block) => block(this);

  /// also: 执行副作用后返回自身
  T also(void Function(T) block) {
    block(this);
    return this;
  }

  /// run: 在上下文中执行代码块
  R run<R>(R Function() block) => block();

  /// apply: 初始化对象并返回自身
  T apply(void Function(T) block) => also(block);

  /// takeIf: 条件为真返回自身，否则 null
  T? takeIf(bool Function(T) predicate) => predicate(this) ? this : null;

  /// takeUnless: 条件为假返回自身，否则 null
  T? takeUnless(bool Function(T) predicate) => !predicate(this) ? this : null;

  /// repeat: 重复执行操作（类似 Kotlin 的 repeat）
  void repeat(int times, void Function(int index) action) {
    for (var i = 0; i < times; i++) {
      action(i);
    }
  }
}

/// 可空类型扩展（处理 T? 的情况）
extension KotlinNullableSyncScope<T extends Object> on T? {
  /// 安全调用 let（类似 ?.let）
  R? safeLet<R>(R Function(T) block) {
    final self = this;
    return self != null ? block(self) : null;
  }

  /// 安全调用 also（类似 ?.also）
  T? safeAlso(void Function(T) block) {
    final self = this;
    if (self != null) block(self);
    return this;
  }

  /// 空合并操作符（类似 Kotlin 的 ?:）
  T orElse(T defaultValue) => this ?? defaultValue;
}

/// 全局函数：with 上下文
R withContext<T extends Object, R>(T obj, R Function(T) block) => block(obj);

/// repeat: 重复执行操作（类似 Kotlin 的 repeat）
void repeat(int times, void Function(int index) action) {
  for (var i = 0; i < times; i++) {
    action(i);
  }
}
