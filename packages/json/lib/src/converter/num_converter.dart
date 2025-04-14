
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
class NumConverter extends JsonConverter<num, dynamic> {
  const NumConverter();

  @override
  num fromJson(dynamic json) {
    return NumDecoder.decodeOrDefault(json);
  }

  @override
  dynamic toJson(num object) => object; // 直接返回 num 类型
}
