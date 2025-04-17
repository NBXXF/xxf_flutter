import 'dart:convert';

import 'package:xxf_log/src/parser/parser.dart';

class JsonParser extends Parser {
  static const int _indent = 4;

  @override
  String? parse(json) {
    if (json is! String) return null;
    if (json.trim().isEmpty) return null;

    try {
      final decoded =
          json.trim().startsWith('[')
              ? jsonDecode(json) as List
              : jsonDecode(json) as Map;

      return JsonEncoder.withIndent(' ' * _indent).convert(decoded);
    } catch (e) {
      return null;
    }
  }
}
