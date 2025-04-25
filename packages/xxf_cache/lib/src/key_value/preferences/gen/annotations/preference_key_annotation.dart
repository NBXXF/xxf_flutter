import 'package:xxf_annotations/xxf_annotations.dart';

@AnnotationClass(description: "SharedPreferences 字段级:定义key,默认值")
@immutable
class PreferenceKey {
  ///覆盖key, If `null`, the field name is used.
  final String? name;

  ///是否区分用户
  final bool? diffUser;

  ///默认值
  final Object? defaultValue;

  const PreferenceKey({this.name, this.diffUser, this.defaultValue});
}
