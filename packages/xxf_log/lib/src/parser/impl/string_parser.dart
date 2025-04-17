import 'package:xxf_log/src/parser/parser.dart';

class StringParser extends Parser{
  @override
  String? parse(data) => data.toString();
}