import 'package:flutter/foundation.dart';
import 'package:xxf_log/src/log_utils.dart';

void logV(dynamic message, {String? tag}) {
  LogUtils.logV(tag: tag, message: message);
}

void logD(dynamic message, {String? tag}) {
  LogUtils.logD(tag: tag, message: message);
}

void logI(dynamic message, {String? tag}) {
  LogUtils.logI(tag: tag, message: message);
}

void logW(dynamic message, {String? tag}) {
  LogUtils.logW(tag: tag, message: message);
}

void logE(dynamic message, {String? tag}) {
  LogUtils.logE(tag: tag, message: message);
}

///日志拓展
extension LogUtilsExtensions on Object {
  static final _tagCache = Expando<String>();

  String _getTag() {
    /// 如果缓存里有，直接返回
    if (_tagCache[this] != null) return _tagCache[this]!;

    /// 否则生成 tag 并缓存
    String className = "$runtimeType";
    String tag = className.length > 10 ? className.substring(0, 10) : className;
    _tagCache[this] = tag;
    return tag;
  }

  void logV(dynamic message, {String? tag}) {
    tag ??= _getTag();
    LogUtils.logV(tag: tag, message: message);
  }

  void logD(dynamic message, {String? tag}) {
    tag ??= _getTag();
    LogUtils.logD(tag: tag, message: message);
  }

  void logI(dynamic message, {String? tag}) {
    tag ??= _getTag();
    LogUtils.logI(tag: tag, message: message);
  }

  void logW(dynamic message, {String? tag}) {
    tag ??= _getTag();
    LogUtils.logW(tag: tag, message: message);
  }

  void logE(dynamic message, {String? tag}) {
    tag ??= _getTag();
    LogUtils.logE(tag: tag, message: message);
  }
}
