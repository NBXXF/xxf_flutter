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

日志封装框架

## Features

/// LogUtils
/// 优势1,先判断环境,是不是应该打印,再执行回调,以回调的形式能避免业务转换或者获取其他变量,包括对象的toString()等方法带来的消耗
/// 优势2,可配置各种数据结构的解析,不单纯是支持string,支持各种数据自定义,请参考parser
//        MaterialPageRoute(
//                     builder:
//                         (context) => LogUtils.config.logger.getLoggerWidget(),
//                   ),

## Getting started

List prerequisites and provide or point to information on how to
start using the package.

## Usage

Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart
const like = 'sample';
```

## Additional information

Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
