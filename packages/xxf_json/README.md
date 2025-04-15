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

Safely handle various JSON parsing errors and support all types!

## Features

Safely handle various JSON parsing errors and support all types  
安全处理各种 JSON 解析错误并支持所有类型

### 反序列化兼容特征一览表

| 类型 \ 是否兼容 | int | double | num | string | bool |
|------------------|-----|--------|-----|--------|------|
| int              | ✔   | ✔      | ✔   | ✔      | ✔    |
| double           | ✔   | ✔      | ✔   | ✔      | ✔    |
| num              | ✔   | ✔      | ✔   | ✔      | ✔    |
| string           | ✔   | ✔      | ✔   | ✔      | ✔    |
| bool             | ✔   | ✔      | ✔   | ✔      | ✔    |

> **术语说明：**  
> `.g.dart`：由 `json_annotation` 生成的中间解析文件  
> DTO：数据传输对象（此处指 JSON 解析模型）

### 中间件

为 JSON 提供如下基础中间件，支持两种兼容模式：

1. **JsonConverter**：兼容基本类型（int、num、double、string、bool），异常时解析为默认值，对齐 js/oc 等语言层兼容。
2. **nullable_converter**：兼容上述基本类型，异常时解析为 null，DTO 字段需声明为可空。
3. **strict_converter**：优先兼容解析，解析失败则报错，帮助快速定位解析问题字段。


集合分类： 
1. primitiveConvertors,///基本类型解析器,安全处理,如遇到失败会转换成默认值
2. primitiveNullableConvertors,///基本类型解析器,安全处理,如遇到失败变成null,适合声明可空类型的字段
3. primitiveStrictConvertors,///基本类型解析器,不安全处理,用于提示内容,比原错误始信息增加 内容本身到日志里面
   ///解决原始报错,不提示具体内容,不好分析模型的那个字段
## Getting started

1. `pubspec.yaml` 中需要添加依赖：

```yaml
dependencies:
xxf_json: ^0.0.2

dev_dependencies:
  build_runner: ^2.4.6
  json_serializable: ^6.7.1
```

## Usage

```dart
export 'package:xxf_json/xxf_json.dart';

@JsonSerializable(
    converters: [...primitiveNullableConvertors])
class Event{
  
}
```
cd 到文件对应的目录
```bash
flutter pub run build_runner build
```

### 常用命令说明

| 命令 | 说明 |
|------|------|
| `flutter pub run build_runner build` | 一次性构建所有 `.g.dart` 文件 |
| `flutter pub run build_runner watch` | 监听文件变更，自动重新生成 |
| `flutter pub run build_runner build --delete-conflicting-outputs` | 如果遇到冲突，自动覆盖旧文件（⚠ 推荐加上） |

### 推荐命令

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Additional information

For more information, please refer to https://github.com/NBXXF/xxf_flutter/tree/main/packages/xxf_json