
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
class DoubleConverter extends JsonConverter<double, dynamic> {
  const DoubleConverter();

  @override
  double fromJson(dynamic json) {
    return DoubleDecoder.decodeOrDefault(json);
  }

  @override
  dynamic toJson(double object) => object;
}
