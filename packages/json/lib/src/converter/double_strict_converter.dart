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
///如果类型不匹配,会给出具体内容给日志
class DoubleStrictConverter extends JsonConverter<double?, dynamic> {
  const DoubleStrictConverter();

  @override
  double? fromJson(dynamic json) {
    return DoubleDecoder.decodeOrException(json);
  }

  @override
  dynamic toJson(double? object) => object;
}
