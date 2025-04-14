
import 'base_decoder.dart';

///int 类型处理中间件
///用法: @JsonKey(fromJson:IntDecoder.decodeOrNull)
///     int? age;
class IntDecoder extends BaseDecoder {
  ///策略1 异常情况解析为空
  static int? decodeOrNull(dynamic json) {
    if (json == null) return null;
    if (json is int) return json;
    if (json is double) return json.toInt();
    if (json is num) return json.toInt();
    if (json is String) return int.tryParse(json);
    if (json is bool) return json ? 1 : 0;
    return null;
  }

  ///策略2 异常情况解析默认值,比@JsonKey(defaultValue: 0)更健壮
  static int decodeOrDefault(dynamic value) {
    return decodeOrNull(value) ?? 0;
  }

  ///策略3 尝试解析异常情况报错并给出错误值
  static int decodeOrException(dynamic value) {
    return decodeOrNull(value) ??
        (throw BaseDecoder.createParseError("int", value));
  }
}
