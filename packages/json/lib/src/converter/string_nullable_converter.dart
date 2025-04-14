
import 'package:json_annotation/json_annotation.dart';

import '../type/string_decoder.dart';

/// 用法一：类上面处理
/// @JsonSerializable(converters: [
///    StringConverter(),
///    IntConverter(),
///    DoubleConverter(),
///    BoolConverter(),
///    ])
///    class MyModel {
///    }
class StringNullableConverter extends JsonConverter<String?, dynamic> {
  const StringNullableConverter();

  @override
  String? fromJson(dynamic json) {
    return StringDecoder.decodeOrNull(json);
  }

  @override
  dynamic toJson(String? object) => object;
}
