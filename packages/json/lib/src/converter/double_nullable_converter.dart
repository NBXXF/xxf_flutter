
import 'package:json_annotation/json_annotation.dart';

import '../type/double_decoder.dart';

/// 用法一：类上面处理
/// @JsonSerializable(converters: [
///    StringConverter(),
///    IntConverter(),
///    DoubleConverter(),
///    BoolConverter(),
///    ])
///    class MyModel {
///    }
class DoubleNullableConverter extends JsonConverter<double?, dynamic> {
  const DoubleNullableConverter();

  @override
  double? fromJson(dynamic json) {
    return DoubleDecoder.decodeOrNull(json);
  }

  @override
  dynamic toJson(double? object) => object;
}
