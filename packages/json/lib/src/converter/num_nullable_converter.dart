
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
class NumNullableConverter extends JsonConverter<num?, dynamic> {
  const NumNullableConverter();

  @override
  num? fromJson(dynamic json) {
    return NumDecoder.decodeOrNull(json);
  }

  @override
  dynamic toJson(num? object) => object; // 直接返回 num 类型
}
