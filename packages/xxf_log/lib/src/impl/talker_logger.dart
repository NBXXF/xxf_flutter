import 'dart:developer' as developer show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:talker_flutter/talker_flutter.dart' as taker_flutter;

import '../logger.dart' show Logger;

/// 使用talker_flutter 实现
class TalkerLogger implements Logger {
  static final TalkerLogger _instance = TalkerLogger._();

  ///这里共享一个就行了,避免缓存更多的Logger
  final logger = taker_flutter.Talker(logger: _DevToolsTalkerLogger());

  factory TalkerLogger() => _instance;

  TalkerLogger._();

  @override
  void logV(String tag, Object log) => logger.verbose('[$tag] $log');

  @override
  void logD(String tag, Object log) => logger.debug('[$tag] $log');

  @override
  void logI(String tag, Object log) => logger.info('[$tag] $log');

  @override
  void logW(String tag, Object log) => logger.warning('[$tag] $log');

  @override
  void logE(String tag, Object log) => logger.error('[$tag] $log');

  @override
  Widget getLoggerWidget() {
    return taker_flutter.TalkerScreen(talker: logger, appBarTitle: "log");
  }
}

class _DevToolsTalkerLogger extends taker_flutter.TalkerLogger {
  @override
  void log(msg, {taker_flutter.LogLevel? level, taker_flutter.AnsiPen? pen}) {
    level ??= taker_flutter.LogLevel.debug;
    if (kDebugMode) {
      developer.log(
        msg,
        name: 'Talker',

        /// 将 Talker 的日志级别映射到整数
        level: level.index * 1000,
      );
    } else {
      debugPrint('[${level.name}] $msg');
    }
  }
}
