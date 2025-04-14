
import 'package:json_annotation/json_annotation.dart';

import '../type/int_decoder.dart';

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
class IntStrictConverter extends JsonConverter<int?, dynamic> {
  const IntStrictConverter();

  @override
  int? fromJson(dynamic json) {
    return IntDecoder.decodeOrException(json);
  }

  @override
  dynamic toJson(int? object) => object;
}
