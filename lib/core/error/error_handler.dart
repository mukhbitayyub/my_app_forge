import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_app_forge/core/error/exceptions.dart';
import 'package:my_app_forge/core/error/failures.dart';

abstract class ErrorHandler {
  static Failure handle(Object error) {
    if (error is DioException) {
      return _handleDioException(error);
    } else if (error is SocketException) {
      return const NetworkFailure();
    } else if (error is FormatException) {
      return ParseFailure(error.message);
    } else if (error is AppException) {
      return switch (error) {
        ServerException(:final statusCode, :final message) =>
          ServerFailure(statusCode, message),
        NetworkException() => const NetworkFailure(),

        CacheException(:final message) => CacheFailure(message),
        UnauthorizedException() => const UnauthorizedFailure(),
        ParseException(:final message) => ParseFailure(message),
        TimeoutException() => const TimeoutFailure(),
      };
    }
    return UnknownFailure(error.toString());
  }

  static Failure _handleDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode == 401) {
      return const UnauthorizedFailure();
    }
    if (statusCode != null && statusCode >= 500) {
      return ServerFailure(statusCode, error.message ?? 'Server Error');
    }
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const TimeoutFailure(),
      DioExceptionType.connectionError => const NetworkFailure(),
      _ => UnknownFailure(error.message ?? 'Connection error'),
    };
  }
}
