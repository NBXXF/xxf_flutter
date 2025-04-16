import 'package:dio/dio.dart';

/**
 * class MyClientAdapter implements ClientAdapter {
    @override
    Dio createClient() {
    return Dio(BaseOptions(baseUrl: 'https://api.example.com'));
    }
    }

    使用
    @CallClientFactory(client: MyClientAdapter)
 */
abstract class ClientAdapter {
  Dio adapt();
}
