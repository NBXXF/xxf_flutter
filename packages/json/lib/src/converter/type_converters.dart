import './bool_converter.dart';
import './bool_nullable_converter.dart';
import './bool_strict_converter.dart';
import './double_converter.dart';
import './double_nullable_converter.dart';
import './double_strict_converter.dart';
import './int_converter.dart';
import './int_nullable_converter.dart';
import './int_strict_converter.dart';
import './num_converter.dart';
import './num_nullable_converter.dart';
import './num_strict_converter.dart';
import './string_converter.dart';
import './string_nullable_converter.dart';
import './string_strict_converter.dart';
import 'package:json_annotation/json_annotation.dart';

///基本类型解析器,安全处理,如遇到失败会转换成默认值
const List<JsonConverter> primitiveConvertors = [
  BoolConverter(),
  DoubleConverter(),
  IntConverter(),
  NumConverter(),
  StringConverter(),
];

///基本类型解析器,安全处理,如遇到失败变成null,适合声明可空类型的字段
const List<JsonConverter> primitiveNullableConvertors = [
  BoolNullableConverter(),
  DoubleNullableConverter(),
  IntNullableConverter(),
  NumNullableConverter(),
  StringNullableConverter()
];

///基本类型解析器,不安全处理,用于提示内容,比原错误始信息增加 内容本身到日志里面
///解决原始报错,不提示具体内容,不好分析模型的那个字段
const List<JsonConverter> primitiveStrictConvertors = [
  BoolStrictConverter(),
  DoubleStrictConverter(),
  IntStrictConverter(),
  NumStrictConverter(),
  StringStrictConverter()
];
