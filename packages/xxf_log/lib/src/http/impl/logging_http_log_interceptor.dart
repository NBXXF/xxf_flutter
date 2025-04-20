import 'package:dio/dio.dart' as dio;
import '../../impl/logging_logger.dart';

///用LoggingLogger实现
class LoggingHttpLogInterceptor extends dio.LogInterceptor {
  LoggingHttpLogInterceptor({
    super.request,
    super.requestHeader,
    super.requestBody,
    super.responseHeader,
    super.responseBody,
    super.error,
  }) : super(
         logPrint: (obj) {
           LoggingLogger().logD("http", obj);
         },
       );
}
