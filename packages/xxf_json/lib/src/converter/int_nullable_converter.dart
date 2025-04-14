
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
class IntNullableConverter extends JsonConverter<int?, dynamic> {
  const IntNullableConverter();

  @override
  int? fromJson(dynamic json) {
    return IntDecoder.decodeOrNull(json);
  }

  @override
  dynamic toJson(int? object) => object;
}
