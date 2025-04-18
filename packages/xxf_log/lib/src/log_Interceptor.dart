import 'log_level.dart';

/// 日志拦截器
abstract class LogInterceptor {
  ///level 参考[LogLevel]
  bool onIntercept(dynamic message, LogLevel level);
}

///日志级别拦截器
class LogLevelInterceptor extends LogInterceptor {
  ///支持打印的级别,参考[LogLevel]
  final LogLevel logLevel;

  LogLevelInterceptor(this.logLevel);

  @override
  bool onIntercept(message, LogLevel level) {
    return level.value >= logLevel.value;
  }
}
