<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

缓存框架

## Features

1. key_value存储,速度比官方shared_preferences 快5倍,底层使用isar
2. 数据库存储

## Getting started
```yaml
dependencies:
  xxf_cache: ^0.0.3
dev_dependencies:
  xxf_cache_generator:
```


## Usage

```dart
  void test() {
  final key = "xxx";
  SharedPreferences.getInstance().getString(key).then((value) {
    logI("=========>cached:$key =$value");
  });
  SharedPreferences.getInstance().putString(key, "$_counter");
}
```

声明式访问[高级用法]
```dart
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

```


isar方法直接操作
```dart
IsarKeyValue().set("xx",1)
///同步方式
IsarSyncKeyValue().set("xx",1)
```

## Additional information

Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
