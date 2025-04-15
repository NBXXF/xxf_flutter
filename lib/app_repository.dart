
import 'package:dio/dio.dart';

import 'retrofit/api_client.dart';

class AppRepository {

  late ApiClient _apiRequest;
  late Dio dio;

  AppRepository() {
    dio = Dio();
    _apiRequest = ApiClient(dio);
 }
}