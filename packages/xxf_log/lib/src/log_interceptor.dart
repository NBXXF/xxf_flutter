import 'log_level.dart';

/// 日志拦截器
abstract class LogInterceptor {
  ///level 参考[LogLevel]
  bool onIntercept(dynamic message, LogLevel level);
}
