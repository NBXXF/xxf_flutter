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

## Getting started

dependencies:
xxf_json: ^0.0.2

## Usage

```dart
@JsonSerializable(
    converters: [...primitiveNullableConvertors])
```

## Additional information

more info take https://github.com/NBXXF