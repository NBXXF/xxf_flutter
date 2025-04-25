import 'dart:io';
import 'package:xxf_cache/xxf_cache.dart';

part 'preference_demo.g.dart';

@Preference(name: "xxf")
abstract class PreferenceDemo implements UserIdProvider {
  @PreferenceKey(defaultValue: "'xx'")
  String? userId;

  @PreferenceKey(defaultValue: 0)
  late int x;

 /// @PreferenceKey(diffUser: true,defaultValue: false)
  bool? isDarkMode;

  ///late DateTime lastLoginTime;

  @override
  String? getUserId() {
    return userId;
  }
}
