import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/usecase/usecase.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';
import 'package:my_app_forge/features/home/domain/repositories/home_repository.dart';

@injectable
class GetCachedItemsUseCase implements UseCase<List<HomeEntity>, NoParams> {
  const GetCachedItemsUseCase(this._repository);

  final HomeRepository _repository;

  @override
  FutureEither<List<HomeEntity>> call(NoParams params) {
    return _repository.getCachedItems();
  }
}
