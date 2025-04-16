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

http框架

## Features

1. 相对于RetrofitGenerator 会生成非空参数的dio对象,这个框架可以生成可空的dio对象
2. 支持注解@UserClientAdapter(client: MyClientAdapter) 在框架内部创建dio对象,比参数更内敛

## Getting started
```yaml
dependencies:
  xxf_http: ^0.0.2

dev_dependencies:
  flutter_test:
  sdk: flutter

  #编译时库
  build_runner:
  json_serializable: ^6.8.0
  #生成自定义的restapi.g.dart
  xxf_http_generator:
```

## Usage

```dart

import 'package:xxf_http/xxf_http.dart';

import '../model/data.dart';
import 'apis.dart';
part 'api_client.g.dart';
@RestApi(baseUrl: "https://gorest.co.in/public-api/")
@UserClientAdapter(client: MyClientAdapter)
///@UseCallAdapter(callAdapter:ResultCallAdapter)
abstract class ApiClient {
  factory ApiClient() {
    return _ApiClient(null);
  }

  @GET(Apis.users)
  Future<ResponseData> getUsers();
}
class MyClientAdapter extends ClientAdapter{
  @override
  Dio adapt() {
    // TODO: 创建自己的client
    throw UnimplementedError();
  }
}
// class ResultCallAdapter<T> extends CallAdapter<Future<T>, Future<Result<T>>> {
//   @override
//   Future<Result<T>> adapt(Future<T> Function() call) async {
//     try {
//       final response = await call();
//       return Success<T>(response);
//     } catch (e) {
//       return Error(e);
//     }
//   }
// }
```

## Additional information

Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
