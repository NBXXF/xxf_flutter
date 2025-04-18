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

## Additional information

Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
