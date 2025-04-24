import 'package:flutter/cupertino.dart';

/**
 * 日志方法	DevTools Logging 视图支持	 说明
 *  stderr.writeln()   ✅              用于将错误信息输出到标准错误流，这些信息也会显示在 DevTools 的 Logging 视图中。同时也会
    print()	      ✅       	           简单直接，适用于快速调试。
    debugPrint()	✅	                 添加了节流机制，防止日志过多导致性能问题。release 模式下仍然会输出日志,可以设置是否显示
    log()         ✅	                 提供结构化日志信息，适用于需要详细日志的场景。Debug 模式：控制台输出 + DevTools 可见;Release 模式:通常你看不到输出
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