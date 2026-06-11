import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/router/app_router.dart';
import 'package:my_app_forge/core/router/app_routes.dart';
import 'package:my_app_forge/core/storage/local_datasource.dart';
import 'package:my_app_forge/core/storage/storage_keys.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._localDataSource, this._appRouter);

  final LocalDataSource _localDataSource;
  final AppRouter _appRouter;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _localDataSource.getString(StorageKeys.authToken);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _localDataSource.remove(StorageKeys.authToken);
      _appRouter.router.go(AppRoutes.onboardingPath);
    }
    super.onError(err, handler);
  }
}
