import 'dart:async';

import 'package:build/build.dart';

/// 一个简单的构建器工厂，返回一个空构建器
Builder xxfGeneratorBuilder(BuilderOptions options) {
  /// 返回一个空的构建器
  return NoOpBuilder();
}

/// 一个简单的构建器，实际不做任何工作
class NoOpBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // 这个构建器不执行任何操作
  }

  @override
  Map<String, List<String>> get buildExtensions => {
    // 你可以根据需要定义扩展
    '.dart': ['.generated.dart'],
  };
}