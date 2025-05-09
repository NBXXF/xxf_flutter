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

All code gen aggregations used by the xxf architecture

## Features

All code gen aggregations used by the xxf architecture

## Getting started
```yaml
dev_dependencies:
  xxf_generator
```

## Usage
聚合的意义没有

Dart 的构建系统在执行构建时，只会扫描当前项目的 pubspec.yaml 中的依赖；
对于代码生成器（builder），即使你通过聚合引用了它们，它们依旧不会被自动“透传加载”；
build_runner 必须看到它们明确地出现在用户项目中，才会调用它们的生成逻辑。

业务必须还手动加一边子项
```dart
const like = 'sample';
```

## Additional information

Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
