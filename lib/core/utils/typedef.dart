import 'package:dartz/dartz.dart';
import 'package:my_app_forge/core/error/failures.dart';

export 'package:my_app_forge/core/usecase/usecase.dart' show FutureEither;

typedef EitherOf<T> = Either<Failure, T>;
typedef NullableEither<T> = Either<Failure, T?>;
