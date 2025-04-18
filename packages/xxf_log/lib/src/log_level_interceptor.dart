import 'log_interceptor.dart' show LogInterceptor;
import 'log_level.dart';

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
