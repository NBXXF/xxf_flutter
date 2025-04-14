import 'package:json_annotation/json_annotation.dart';

import '../type/bool_decoder.dart';

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
class BoolStrictConverter extends JsonConverter<bool?, dynamic> {
  const BoolStrictConverter();

  @override
  bool? fromJson(dynamic json) {
    return BoolDecoder.decodeOrException(json);
  }

  @override
  dynamic toJson(bool? object) => object;
}
