import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart' as logging;

import '../logger.dart' show Logger;

/// 用官方的logging 实现
class LoggingLogger implements Logger {
  static final LoggingLogger _instance = LoggingLogger._();

  ///这里共享一个就行了,避免缓存更多的Logger
  final logger = logging.Logger('logging')..level = logging.Level.ALL;

  factory LoggingLogger() => _instance;

  LoggingLogger._();

  @override
  void logV(String tag, Object log) => logger.finest('[$tag] $log');

  @override
  void logD(String tag, Object log) => logger.fine('[$tag] $log');

  @override
  void logI(String tag, Object log) => logger.info('[$tag] $log');

  @override
  void logW(String tag, Object log) => logger.warning('[$tag] $log');

  @override
  void logE(String tag, Object log) => logger.severe('[$tag] $log');

  @override
  Widget getLoggerWidget() {
    return Text("un support");
  }
}
