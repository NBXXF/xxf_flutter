import 'package:xxf_annotations/xxf_annotations.dart';

@AnnotationClass(description: "SharedPreferences 定义命名空间")
@immutable
class Preference {
  final String? name;

  const Preference({this.name});
}
