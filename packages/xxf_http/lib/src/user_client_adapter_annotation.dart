import 'package:xxf_annotations/xxf_annotations.dart';

import './client_adapter.dart';

@AnnotationClass(description:"自定义client dio")
class UserClientAdapter {
  /// [ ClientAdapter ]类型
  final Type client;

  const UserClientAdapter({required this.client});
}
