import 'log_config.dart' show LogConfig;
import 'log_level.dart' show LogLevel;

/// LogUtils
/// 优势1,先判断环境,是不是应该打印,再执行回调,以回调的形式能避免业务转换或者获取其他变量,包括对象的toString()等方法带来的消耗
/// 优势2,可配置各种数据结构的解析,不单纯是支持string,支持各种数据自定义,请参考parser
//        MaterialPageRoute(
//                     builder:
//                         (context) => LogUtils.config.logger.getLoggerWidget(),
//                   ),
class LogUtils {
  static final LogConfig config = LogConfig();

  static String _getTag() {
    // final trace = StackTrace.current.toString().split("\n");
    // final targetLine = trace.length > 2 ? trace[2] : trace.first;
    // final match = RegExp(r'#\d+\s+([^\s\(]+)').firstMatch(targetLine);
    // return match?.group(1)?.split('.').last ?? 'Log';
    return "Log";
  }

  static bool _shouldLog(dynamic message, LogLevel level) {
    if (config.logInterceptor != null) {
      return !config.logInterceptor!.onIntercept(message, level);
    } else {
      return true;
    }
  }

  static void logV({String? tag, dynamic message}) {
    if (!_shouldLog(message, LogLevel.verbose)) return;
    config.logger.logV(tag ?? _getTag(), _parse(message));
  }

  static void logD({String? tag, dynamic message}) {
    if (!_shouldLog(message, LogLevel.debug)) return;
    config.logger.logD(tag ?? _getTag(), _parse(message));
  }

  static void logI({String? tag, dynamic message}) {
    if (!_shouldLog(message, LogLevel.info)) return;
    config.logger.logI(tag ?? _getTag(), _parse(message));
  }

  static void logW({String? tag, dynamic message}) {
    if (!_shouldLog(message, LogLevel.warn)) return;
    config.logger.logW(tag ?? _getTag(), _parse(message));
  }

  static void logE({String? tag, dynamic message}) {
    if (!_shouldLog(message, LogLevel.error)) return;
    config.logger.logE(tag ?? _getTag(), _parse(message));
  }

  static String _parse(dynamic message) {
    try {
      String msg;
      // ignore: inference_failure_on_function_return_type
      if (message is Function()) {
        msg = message().toString();
      } else {
        msg = message;
      }
      return config.dispatch(msg);
    } catch (e, s) {
      return '解析失败: $e\n$s';
    }
  }
}
