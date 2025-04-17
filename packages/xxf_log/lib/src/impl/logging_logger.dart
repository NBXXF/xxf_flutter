import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart' as logging;

import '../logger.dart' show Logger;

/// 用官方的logging 实现
class LoggingLogger implements Logger {
  ///这里共享一个就行了,避免缓存更多的Logger
  final _logger = logging.Logger('logging')..level = logging.Level.ALL;

  @override
  void logV(String tag, Object log) => _logger.finest('[$tag] $log');

  @override
  void logD(String tag, Object log) => _logger.fine('[$tag] $log');

  @override
  void logI(String tag, Object log) => _logger.info('[$tag] $log');

  @override
  void logW(String tag, Object log) => _logger.warning('[$tag] $log');

  @override
  void logE(String tag, Object log) => _logger.severe('[$tag] $log');

  @override
  Widget getLoggerWidget() {
    return Text("un support");
  }
}
