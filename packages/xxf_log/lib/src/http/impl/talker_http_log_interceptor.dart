import 'package:dio/dio.dart' as dio;
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../../impl/talker_logger.dart';

///TalkerDioLogger
class TalkerHttpLogInterceptor extends dio.LogInterceptor {
  late final TalkerDioLogger _logger;

  TalkerHttpLogInterceptor({
    super.request,
    bool requestHeader = true,
    bool requestBody = true,
    bool responseHeader = true,
    bool responseBody = true,
    super.error,
    @Deprecated("Use TalkerDioLoggerSettings instead")
    super.logPrint, // 标记废弃，但不影响编译
  }) : super(
         requestHeader: requestHeader,
         requestBody: requestBody,
         responseHeader: responseHeader,
         responseBody: responseBody,
       ) {
    /// 在构造函数体内初始化 _logger，确保父类参数已赋值
    _logger = TalkerDioLogger(
      talker: TalkerLogger().logger,
      settings: TalkerDioLoggerSettings(
        printRequestData: requestBody,

        /// 对应父类 requestBody
        printRequestHeaders: requestHeader,
        printResponseData: responseBody,
        printResponseHeaders: responseHeader,
      ),
    );
  }

  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    _logger.onRequest(options, handler);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    _logger.onError(err, handler);
  }

  @override
  void onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    _logger.onResponse(response, handler);
  }
}
