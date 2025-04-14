
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

class BoolNullableConverter extends JsonConverter<bool?, dynamic> {
  const BoolNullableConverter();

  @override
  bool? fromJson(dynamic json) {
    return BoolDecoder.decodeOrNull(json);
  }

  @override
  dynamic toJson(bool? object) => object;
}
