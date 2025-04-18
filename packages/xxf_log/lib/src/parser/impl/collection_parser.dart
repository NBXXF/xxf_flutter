import 'package:xxf_log/src/parser/log_parser.dart';

///处理数组
class CollectionParser extends LogParser {
  static const String lineSeparator = '\n';

  @override
  String? parse(dynamic data) {
    if (data is! Iterable) {
      return null;
    }
    final buffer = StringBuffer(
        'collection size = ${data.length} [$lineSeparator');

    if (data.isNotEmpty) {
      int index = 0;
      for (final item in data) {
        final itemString = '[$index]: $item';
        buffer.write(itemString);
        if (index < data.length - 1) {
          buffer.write(',$lineSeparator');
        } else {
          buffer.write(lineSeparator);
        }
        index++;
      }
    }

    buffer.write(']');
    return buffer.toString();
  }
}
