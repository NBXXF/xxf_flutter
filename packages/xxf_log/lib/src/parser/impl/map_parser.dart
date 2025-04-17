import 'package:xxf_log/src/parser/parser.dart';

class MapParser extends Parser {
  static const String lineSeparator = '\n';

  @override
  String? parse(dynamic data) {
    if (data is! Map) {
      return null;
    }
    final buffer = StringBuffer('');

    data.forEach((key, value) {
      String formattedValue;
      if (value is String) {
        formattedValue = '"$value"';
      } else if (value is String && value.length == 1) {
        /// 单字符字符串特殊处理（Dart 没有 Char 类型）
        formattedValue = "'$value'";
      } else {
        formattedValue = '$value';
      }

      buffer.write('$key -> $formattedValue$lineSeparator');
    });

    buffer.write(']');
    return buffer.toString();
  }
}
