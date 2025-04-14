
import 'package:json_annotation/json_annotation.dart';

import '../type/num_decoder.dart';

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
class NumStrictConverter extends JsonConverter<num?, dynamic> {
  const NumStrictConverter();

  @override
  num? fromJson(dynamic json) {
    return NumDecoder.decodeOrException(json);
  }

  @override
  dynamic toJson(num? object) => object; // 直接返回 num 类型
}
