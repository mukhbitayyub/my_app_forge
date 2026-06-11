import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/error/exceptions.dart';
import 'package:my_app_forge/features/home/data/datasources/home_remote_datasource.dart';
import 'package:my_app_forge/features/home/data/models/home_model.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  const HomeRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<HomeModel>> getHomeItems({int? page, int? limit}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/home',
        queryParameters: {
          'page':? page,
          'limit':? limit,
        },
      );
      final data = response.data?['data'] as List<dynamic>? ?? [];
      return data
          .map((item) => HomeModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(500, e.toString());
    }
  }

  @override
  Future<HomeModel> getHomeItemById(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/home/$id');
      final data = response.data?['data'] as Map<String, dynamic>? ?? response.data ?? {};
      return HomeModel.fromJson(data);
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(500, e.toString());
    }
  }

  @override
  Future<void> bookmarkItem(String id) async {
    try {
      await _dio.post<dynamic>('/home/$id/bookmark');
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(500, e.toString());
    }
  }

  @override
  Future<void> removeBookmark(String id) async {
    try {
      await _dio.delete<dynamic>('/home/$id/bookmark');
    } on DioException catch (e) {
      throw _handleDioException(e);
    } catch (e) {
      throw ServerException(500, e.toString());
    }
  }

  AppException _handleDioException(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode ?? 500;
    
    var message = e.message ?? 'An unknown remote error occurred';
    if (response?.data is Map) {
      final dataMap = response?.data as Map<String, dynamic>;
      message = dataMap['message'] as String? ?? dataMap['error'] as String? ?? message;
    } else if (response?.data is String) {
      message = response?.data as String;
    }

    if (statusCode == 401) {
      return const UnauthorizedException();
    }
    
    return ServerException(statusCode, message);
  }
}
