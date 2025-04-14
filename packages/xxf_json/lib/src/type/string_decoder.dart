
import 'base_decoder.dart';

///int 类型处理中间件
///用法: @JsonKey(fromJson:StringDecoder.decodeOrNull)
///     String? name;
class StringDecoder extends BaseDecoder {
  ///策略1 异常情况解析为空
  static String? decodeOrNull(dynamic json) {
    if (json == null) return null;
    return json.toString();
  }

  ///策略2 异常情况解析默认值,比@JsonKey(defaultValue: "")更健壮
  static String decodeOrDefault(dynamic value) {
    return decodeOrNull(value) ?? "";
  }

  ///策略3 尝试解析异常情况报错并给出错误值
  static String decodeOrException(dynamic value) {
    return decodeOrNull(value) ??
        (throw BaseDecoder.createParseError("String", value));
  }
}
