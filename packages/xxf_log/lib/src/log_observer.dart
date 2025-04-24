import 'log_level.dart';

/// 日志观察者
abstract class LogObserver {
  ///可用于记录文件
  void onLogged(
    LogLevel level,
    dynamic message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  );
}
