import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart' as logging;
import 'package:logging/logging.dart' show hierarchicalLoggingEnabled;
import 'package:xxf_log/src/log_utils.dart';

import '../logger.dart' show Logger;
import '../utils/out_put_utils.dart';

/// 用官方的logging 实现
class LoggingLogger implements Logger {
  static final LoggingLogger _instance = LoggingLogger._();

  ///这里共享一个就行了,避免缓存更多的Logger
  final logger = logging.Logger('logging')..level = logging.Level.ALL;

  factory LoggingLogger() {
    ///自定义的logger 设置level 就必须hierarchicalLoggingEnabled 设置为true
    hierarchicalLoggingEnabled = true;

    /// 添加默认的 PrintHandler（输出到控制台）
    logging.Logger.root.onRecord.listen((record) async {
      ///Flutter 的 DevTools 日志面板监听的是 dart:developer 的 log() 函数或 debugPrint() 的输出，而不是直接监听 print()。
      if (kDebugMode) {
        ///使用 developer.log 输出到 DevTools
        developer.log(
          record.message,
          name: record.loggerName,
          level: record.level.value,
          time: record.time,
          error: record.error,
          stackTrace: record.stackTrace,
        );
      } else {
        final buffer = StringBuffer();

        /// 基础信息
        buffer.write('${record.level.name} [${record.time}] ${record.message}');

        /// 错误信息
        if (record.error != null) {
          buffer.write('\n  ERROR: ${record.error}');
        }

        /// 堆栈跟踪
        if (record.stackTrace != null) {
          buffer.write('\n  STACKTRACE:\n${record.stackTrace}');
        }

        /// 输出完整日志
        OutPutUtils.releaseOut(buffer.toString());
      }
    });

    // 设置日志级别
    logging.Logger.root.level = logging.Level.ALL;
    return _instance;
  }

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
