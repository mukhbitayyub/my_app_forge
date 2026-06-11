import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable implements Exception {
  const Failure();
  String get userMessage;
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure(this.statusCode, this.message);
  final int statusCode; final String message;
  @override String get userMessage => 'Server error occurred ($statusCode).';
  @override List<Object?> get props => [statusCode, message];
}

class NetworkFailure extends Failure {
  const NetworkFailure();
  @override String get userMessage => 'Please check your internet connection.';
}

class CacheFailure extends Failure {
  const CacheFailure(this.message);
  final String message;
  @override String get userMessage => 'Local caching error occurred.';
  @override List<Object?> get props => [message];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
  @override String get userMessage => 'Session expired. Please log in again.';
}

class ParseFailure extends Failure {
  const ParseFailure(this.message);
  final String message;
  @override String get userMessage => 'Failed to process data.';
  @override List<Object?> get props => [message];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure();
  @override String get userMessage => 'Connection timed out. Please try again.';
}

class UnknownFailure extends Failure {
  const UnknownFailure(this.message);
  final String message;
  @override String get userMessage => 'An unexpected error occurred.';
  @override List<Object?> get props => [message];
}
