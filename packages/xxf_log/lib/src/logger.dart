import 'package:flutter/cupertino.dart';

/// 日志接口
abstract class Logger {
  void logV(String tag, Object log);
  void logD(String tag, Object log);
  void logI(String tag, Object log);
  void logW(String tag, Object log);
  void logE(String tag, Object log);

  Widget getLoggerWidget();
}