import 'package:xxf_log/src/parser/impl/collection_parser.dart';
import 'package:xxf_log/src/parser/impl/json_parser.dart';
import 'package:xxf_log/src/parser/impl/map_parser.dart';
import 'package:xxf_log/src/parser/impl/string_parser.dart';
import 'package:xxf_log/src/parser/log_parser.dart';

import '../xxf_log.dart' show TalkerLogger;
import 'log_interceptor.dart' show LogInterceptor;
import 'log_observer.dart';
import 'logger.dart' show Logger;

/// 日志配置
class LogConfig {
  LogInterceptor? interceptor;
  Logger logger;
  List<LogParser> parsers;
  LogObserver? observer;

  LogConfig({
    this.interceptor,
    Logger? logger,
    List<LogParser>? parsers,
    this.observer,
  }) : logger = logger ?? TalkerLogger(),

       ///默认支持集合,字典,json
       parsers =
           parsers ??
           [CollectionParser(), MapParser(), JsonParser(), StringParser()];

  String dispatch(Object data) {
    for (var parser in parsers) {
      var parse = parser.parse(data);
      if (parse != null && parse.isNotEmpty) {
        return parse;
      }
    }
    return data.toString();
  }
}
