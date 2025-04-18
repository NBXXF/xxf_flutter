import 'package:xxf_log/src/parser/log_parser.dart';

class StringParser extends LogParser{
  @override
  String? parse(data) => data.toString();
}