/// 定义密封类 Result
sealed class Result<T> {
  const Result();

  /// 工厂方法：成功
  const factory Result.success(T value) = Success<T>;

  /// 工厂方法：失败
  const factory Result.failure(Object error, [StackTrace? stackTrace]) =
      Failure<T>;

  bool get isSuccess => this is Success;

  bool get isFailure => this is Failure;

  /// 抽象方法：获取值或抛出异常
  T getOrThrow();

  ///失败就返回null
  T? getOrNull();

  ///失败返回异常
  Object? exceptionOrNull();
}

/// 成功子类
class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  @override
  T getOrThrow() => value;

  @override
  Object? exceptionOrNull() {
    return null;
  }

  @override
  T? getOrNull() {
    return value;
  }
}

/// 失败子类
class Failure<T> extends Result<T> {
  final Object error;
  final StackTrace? stackTrace;

  const Failure(this.error, [this.stackTrace]);

  @override
  T getOrThrow() {
    throw Error.throwWithStackTrace(error, stackTrace ?? StackTrace.current);
  }

  @override
  Object? exceptionOrNull() {
    return error;
  }

  @override
  T? getOrNull() {
    return null;
  }
}

/// 全局函数：类似 Kotlin 的 runCatching
Result<R> runCatching<R>(R Function() block) {
  try {
    return Result.success(block());
  } catch (e, stack) {
    return Result.failure(e, stack);
  }
}
