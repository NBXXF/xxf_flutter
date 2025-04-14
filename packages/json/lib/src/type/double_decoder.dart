
import 'base_decoder.dart';

///double 类型处理中间件
///用法: @JsonKey(fromJson:DoubleDecoder.decodeOrNull)
///      double? price;
class DoubleDecoder extends BaseDecoder {
  ///策略1 异常情况解析为空
  static double? decodeOrNull(dynamic json) {
    if (json == null) return null;
    if (json is int) return json.toDouble();
    if (json is double) return json;
    if (json is num) return json.toDouble();
    if (json is String) return double.tryParse(json);
    if (json is bool) return json ? 1.0 : 0.0;
    return null;
  }

  ///策略2 异常情况解析默认值,比@JsonKey(defaultValue: 0.0)更健壮
  static double decodeOrDefault(dynamic value) {
    return decodeOrNull(value) ?? 0.0;
  }

  ///策略3 尝试解析异常情况报错并给出错误值
  static double decodeOrException(dynamic value) {
    return decodeOrNull(value) ??
        (throw BaseDecoder.createParseError("double", value));
  }
}
