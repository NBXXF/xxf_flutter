import 'dart:io';
import 'package:xxf_cache/xxf_cache.dart';

part 'kv_xxf.g.dart';

@Preference(name: "xxf")
abstract class KvXxf implements UserIdProvider {
  String? userId;

  @PreferenceKey(name: "age",diffUser: true)
  int? age;

  double? size;

  late int x;

  bool? isDarkMode;

  DateTime? lastLoginTime;

  @override
  String? getUserId() {
    return userId;
  }
}
