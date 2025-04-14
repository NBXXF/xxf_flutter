
import 'base_decoder.dart';

///bool类型处理中间件
///用法: @JsonKey(fromJson:StringDecoder.decodeOrNull)
///      bool? isAllDay
class BoolDecoder extends BaseDecoder {
  ///策略1 异常情况解析为空
  static bool? decodeOrNull(dynamic json) {
    if (json == null) return null;
    if (json is int) return json != 0;
    if (json is double) return json != 0.0;
    if (json is num) return json.toInt() != 0;
    if (json is bool) return json;
    if (json is String) return json.toLowerCase() == 'true';
    return null;
  }

  ///策略2 异常情况解析默认值,比@JsonKey(defaultValue: false)更健壮
  static bool decodeOrDefault(dynamic value) {
    return decodeOrNull(value) ?? false;
  }

  ///策略3 尝试解析异常情况报错并给出错误值
  static bool decodeOrException(dynamic value) {
    return decodeOrNull(value) ??
        (throw BaseDecoder.createParseError("bool", value));
  }
}
