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

class BoolConverter extends JsonConverter<bool, dynamic> {
  const BoolConverter();

  @override
  bool fromJson(dynamic json) {
    return BoolDecoder.decodeOrDefault(json);
  }

  @override
  dynamic toJson(bool object) => object;
}
