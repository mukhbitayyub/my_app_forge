import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/usecase/usecase.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';
import 'package:my_app_forge/features/home/domain/repositories/home_repository.dart';

@injectable
class GetHomeItemsUseCase implements UseCase<List<HomeEntity>, GetHomeItemsParams> {
  const GetHomeItemsUseCase(this._repository);

  final HomeRepository _repository;

  @override
  FutureEither<List<HomeEntity>> call(GetHomeItemsParams params) {
    return _repository.getHomeItems(page: params.page, limit: params.limit);
  }
}

class GetHomeItemsParams extends Equatable {
  const GetHomeItemsParams({required this.page, required this.limit});

  final int page;
  final int limit;

  @override
  List<Object?> get props => [page, limit];
}
