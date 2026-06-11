import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/network/api_endpoints.dart';
import 'package:my_app_forge/core/network/auth_interceptor.dart';
import 'package:my_app_forge/core/network/logging_interceptor.dart';

@lazySingleton
class ApiClient {
  ApiClient(
    this.dio,
    AuthInterceptor authInterceptor,
    LoggingInterceptor loggingInterceptor,
  ) {
    dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      contentType: 'application/json',
    );
    dio.interceptors.addAll([
      authInterceptor,
      loggingInterceptor,
    ]);
  }

  final Dio dio;
}
