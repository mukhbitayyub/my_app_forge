// This ignore is required because Clean Architecture UseCase contracts
// intentionally declare a single abstract 'call' method.
// ignore_for_file: one_member_abstracts

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app_forge/core/error/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

abstract class UseCase<T, Params> {
  FutureEither<T> call(Params params);
}

abstract class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object?> get props => [];
}
