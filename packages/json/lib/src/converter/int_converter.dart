
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
class IntConverter extends JsonConverter<int, dynamic> {
  const IntConverter();

  @override
  int fromJson(dynamic json) {
    return IntDecoder.decodeOrDefault(json);
  }

  @override
  dynamic toJson(int object) => object;
}
