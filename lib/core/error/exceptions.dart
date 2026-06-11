sealed class AppException implements Exception {}

class ServerException implements AppException {
  const ServerException(this.statusCode, this.message);
  final int statusCode; final String message;
  @override String toString() => 'ServerException($statusCode): $message';
}

class NetworkException implements AppException {
  const NetworkException(this.message);
  final String message;
  @override String toString() => 'NetworkException: $message';
}

class CacheException implements AppException {
  const CacheException(this.message);
  final String message;
  @override String toString() => 'CacheException: $message';
}

class UnauthorizedException implements AppException {
  const UnauthorizedException();
  @override String toString() => 'UnauthorizedException';
}

class ParseException implements AppException {
  const ParseException(this.message);
  final String message;
  @override String toString() => 'ParseException: $message';
}

class TimeoutException implements AppException {
  const TimeoutException();
  @override String toString() => 'TimeoutException';
}
