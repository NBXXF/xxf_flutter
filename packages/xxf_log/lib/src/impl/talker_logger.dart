import 'package:flutter/widgets.dart';
import 'package:talker_flutter/talker_flutter.dart' show Talker, TalkerScreen;

import '../logger.dart' show Logger;

/// 使用talker_flutter 实现
class TalkerLogger implements Logger {
  static final TalkerLogger _instance = TalkerLogger._();

  ///这里共享一个就行了,避免缓存更多的Logger
  final logger = Talker();

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
    return TalkerScreen(talker: logger, appBarTitle: "log");
  }
}
