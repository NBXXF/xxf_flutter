import 'package:flutter/cupertino.dart';

/**
 * 日志方法	DevTools Logging 视图支持	 说明
    print()	      ✅       	           简单直接，适用于快速调试。
    debugPrint()	✅	                 添加了节流机制，防止日志过多导致性能问题。release 模式下仍然会输出日志
    log()         ✅	                 提供结构化日志信息，适用于需要详细日志的场景。
    logging 包	  ⚠️	                 默认不显示在 DevTools 中，需要配置输出到 print() 或 log()。
    talker 包	    ⚠️	                 默认不显示在 DevTools 中，需要配置输出到 print() 或 log()。
 */

/// 日志接口
abstract class Logger {
  void logV(String tag, Object log);
  void logD(String tag, Object log);
  void logI(String tag, Object log);
  void logW(String tag, Object log);
  void logE(String tag, Object log);

  Widget getLoggerWidget();
}