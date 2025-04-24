import 'dart:developer' as developer show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:talker_flutter/talker_flutter.dart' as taker_flutter;

import '../logger.dart' show Logger;

/// 使用talker_flutter 实现
class TalkerLogger implements Logger {
  static final TalkerLogger _instance = TalkerLogger._();

  ///这里共享一个就行了,避免缓存更多的Logger
  final logger = taker_flutter.Talker(
    logger: kDebugMode ? _DevToolsTalkerLogger() : null,
  );

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

///打印到DevTools 面板
class _DevToolsTalkerLogger extends taker_flutter.TalkerLogger {
  _DevToolsTalkerLogger({super.settings, super.formatter, super.filter});

  @override
  void log(msg, {taker_flutter.LogLevel? level, taker_flutter.AnsiPen? pen}) {
    if (!settings.enable) {
      return;
    }
    final selectedLevel = level ?? taker_flutter.LogLevel.debug;
    final selectedPen =
        pen ??
        settings.colors[selectedLevel] ??
        (taker_flutter.AnsiPen()..gray());

    if (filter.shouldLog(msg, selectedLevel)) {
      final formattedMsg = formatter.fmt(
        taker_flutter.LogDetails(
          message: msg,
          level: selectedLevel,
          pen: selectedPen,
        ),
        settings,
      );
      developer.log(
        formattedMsg,
        name: settings.defaultTitle,
        level: mapLogLevelToDeveloperLevel(selectedLevel),
        error: error,
        stackTrace: null,
        time: null,
      );
    }
  }

  /// 转换成developer的日志级别
  int mapLogLevelToDeveloperLevel(taker_flutter.LogLevel level) {
    switch (level) {
      case taker_flutter.LogLevel.verbose:
        return 300; // FINEST
      case taker_flutter.LogLevel.debug:
        return 500; // FINE
      case taker_flutter.LogLevel.info:
        return 800; // INFO
      case taker_flutter.LogLevel.warning:
        return 900; // WARNING
      case taker_flutter.LogLevel.error:
        return 1000; // SEVERE
      case taker_flutter.LogLevel.critical:
        return 1200; // SHOUT
      default:
        return 800; // 默认 INFO
    }
  }
}
