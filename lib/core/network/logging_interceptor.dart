import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
      debugPrint('--> ${options.method} ${options.uri}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      final startTime = response.requestOptions.extra['startTime'] as int?;
      final duration = startTime != null
          ? DateTime.now().millisecondsSinceEpoch - startTime
          : 0;
      debugPrint(
        '<-- ${response.statusCode} ${response.requestOptions.method} '
        '${response.requestOptions.uri} (${duration}ms)',
      );
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final startTime = err.requestOptions.extra['startTime'] as int?;
      final duration = startTime != null
          ? DateTime.now().millisecondsSinceEpoch - startTime
          : 0;
      debugPrint(
        'XXX ${err.response?.statusCode ?? "ERROR"} ${err.requestOptions.method} '
        '${err.requestOptions.uri} (${duration}ms) - ${err.message}',
      );
    }
    super.onError(err, handler);
  }
}
