
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
///如果类型不匹配,会给出具体内容给日志
class StringStrictConverter extends JsonConverter<String?, dynamic> {
  const StringStrictConverter();

  @override
  String? fromJson(dynamic json) {
    return StringDecoder.decodeOrException(json);
  }

  @override
  dynamic toJson(String? object) => object;
}
