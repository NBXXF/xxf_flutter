import 'package:xxf_annotations/xxf_annotations.dart';

import '../preference_property_converter.dart';
@AnnotationClass(description: "SharedPreferences 定义类型转换器")
@immutable
class PreferenceConverter {
  /// [PreferencePropertyConverter]类型
  final Type converter;

  const PreferenceConverter({required this.converter});
}
