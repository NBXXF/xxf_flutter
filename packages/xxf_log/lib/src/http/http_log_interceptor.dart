import 'package:dio/dio.dart' as dio;
import 'package:xxf_log/src/log_utils.dart';

import 'impl/logging_http_log_interceptor.dart' show LoggingHttpLogInterceptor;
import 'impl/talker_http_log_interceptor.dart' show TalkerHttpLogInterceptor;
import '../impl/talker_logger.dart';

/// 网络日志拦截器（基于 TalkerDioLogger 包装）
class HttpLogInterceptor extends dio.LogInterceptor {
  dio.LogInterceptor? _proxy;

  HttpLogInterceptor({
    super.request,
    super.requestHeader,
    super.requestBody,
    super.responseHeader,
    super.responseBody,
    super.error,
  });

  dio.LogInterceptor getProxyLogInterceptor() {
    if (LogUtils.config.logger is TalkerLogger) {
      _proxy = asTypeOrDefault<TalkerHttpLogInterceptor>(
        () => TalkerHttpLogInterceptor(),
      );
    } else {
      _proxy = asTypeOrDefault<LoggingHttpLogInterceptor>(
        () => LoggingHttpLogInterceptor(),
      );
    }
    return _proxy!;
  }

  T asTypeOrDefault<T>(T Function() createFactory) =>
      this is T ? (this as T) : createFactory();

  @override
  void onRequest(
    dio.RequestOptions options,
    dio.RequestInterceptorHandler handler,
  ) {
    getProxyLogInterceptor().onRequest(options, handler);
  }

  @override
  void onError(dio.DioException err, dio.ErrorInterceptorHandler handler) {
    getProxyLogInterceptor().onError(err, handler);
  }

  @override
  void onResponse(
    dio.Response response,
    dio.ResponseInterceptorHandler handler,
  ) {
    getProxyLogInterceptor().onResponse(response, handler);
  }
}
