import 'package:xxf_log/src/log_utils.dart';

/// [message]：支持function,eg. ()=>xxx
void logV(
  dynamic message, {
  String? tag,
  Object? error,
  StackTrace? stackTrace,
}) {
  LogUtils.logV(message, tag: tag, error: error, stackTrace: stackTrace);
}

/// [message]：支持function,eg. ()=>xxx
void logD(
  dynamic message, {
  String? tag,
  Object? error,
  StackTrace? stackTrace,
}) {
  LogUtils.logD(message, tag: tag, error: error, stackTrace: stackTrace);
}

/// [message]：支持function,eg. ()=>xxx
void logI(
  dynamic message, {
  String? tag,
  Object? error,
  StackTrace? stackTrace,
}) {
  LogUtils.logI(message, tag: tag, error: error, stackTrace: stackTrace);
}

/// [message]：支持function,eg. ()=>xxx
void logW(
  dynamic message, {
  String? tag,
  Object? error,
  StackTrace? stackTrace,
}) {
  LogUtils.logW(message, tag: tag, error: error, stackTrace: stackTrace);
}

/// [message]：支持function,eg. ()=>xxx
void logE(
  dynamic message, {
  String? tag,
  Object? error,
  StackTrace? stackTrace,
}) {
  LogUtils.logE(message, tag: tag, error: error, stackTrace: stackTrace);
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

  /// [message]：支持function,eg. ()=>xxx
  void logV(
    dynamic message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    tag ??= _getTag();
    LogUtils.logV(message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// [message]：支持function,eg. ()=>xxx
  void logD(
    dynamic message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    tag ??= _getTag();
    LogUtils.logD(message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// [message]：支持function,eg. ()=>xxx
  void logI(
    dynamic message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    tag ??= _getTag();
    LogUtils.logI(message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// [message]：支持function,eg. ()=>xxx
  void logW(
    dynamic message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    tag ??= _getTag();
    LogUtils.logW(message, tag: tag, error: error, stackTrace: stackTrace);
  }

  /// [message]：支持function,eg. ()=>xxx
  void logE(
    dynamic message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    tag ??= _getTag();
    LogUtils.logE(message, tag: tag, error: error, stackTrace: stackTrace);
  }
}
