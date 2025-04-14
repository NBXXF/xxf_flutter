
import 'base_decoder.dart';

///num 类型处理中间件
///用法: @JsonKey(fromJson:NumDecoder.decodeOrNull)
///     num? price;
class NumDecoder extends BaseDecoder {
  ///策略1 异常情况解析为空
  static num? decodeOrNull(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is double) return json;
    if (json is num) return json;
    if (json is String) return num.tryParse(json);
    if (json is bool) return json ? 1 : 0;
    return null;
  }

  ///策略2 异常情况解析默认值,比@JsonKey(defaultValue: 0.0)更健壮
  static num decodeOrDefault(dynamic value) {
    return decodeOrNull(value) ?? 0.0;
  }

  ///策略3 尝试解析异常情况报错并给出错误值
  static num decodeOrException(dynamic value) {
    return decodeOrNull(value) ??
        (throw BaseDecoder.createParseError("num", value));
  }
}
