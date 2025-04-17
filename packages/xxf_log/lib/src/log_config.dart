import 'package:xxf_log/src/parser/impl/collection_parser.dart';
import 'package:xxf_log/src/parser/impl/json_parser.dart';
import 'package:xxf_log/src/parser/impl/map_parser.dart';
import 'package:xxf_log/src/parser/impl/string_parser.dart';
import 'package:xxf_log/src/parser/parser.dart';

import '../xxf_log.dart' show TalkerLogger;
import 'log_Interceptor.dart' show LogInterceptor;
import 'logger.dart' show Logger;

/// 日志配置
class LogConfig {
  LogInterceptor? logInterceptor;
  Logger logger;
  List<Parser> parsers;

  LogConfig({this.logInterceptor, Logger? logger, List<Parser>? parsers})
    : logger = logger ?? TalkerLogger(),
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
