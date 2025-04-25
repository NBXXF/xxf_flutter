import 'dart:io';
import 'package:xxf_cache/xxf_cache.dart';

part 'preference_demo.g.dart';

@Preference(name: "xxf")
abstract class PreferenceDemo extends UserIdProvider {
  static final PreferenceDemo instance = _PreferenceDemo();

  ///支持自定义key
  @PreferenceKey(name: "_userId")
  String? userId;

  ///支持默认值
  @PreferenceKey(defaultValue: 0)
  late int x;

  ///支持区分不同用户
  @PreferenceKey(diffUser: true)
  bool? isDarkMode;

  ///自定义类型
  @PreferenceConverter(converter: DateTimeConverter)
  DateTime? lastLoginTime;

  @override
  String? getUserId() {
    return "xy6";
  }
}

class DateTimeConverter extends PreferencePropertyConverter<DateTime?> {
  @override
  DateTime? convertToEntityProperty(String? databaseValue) {
    return (databaseValue == null || databaseValue.isEmpty)
        ? null
        : DateTime.tryParse(databaseValue);
  }

  @override
  String? convertToPreferenceValue(DateTime? property) {
    return property?.toIso8601String();
  }
}
