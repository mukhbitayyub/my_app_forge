import 'package:dartz/dartz.dart';
import 'package:my_app_forge/core/usecase/usecase.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';

abstract interface class HomeRepository {
  FutureEither<List<HomeEntity>> getHomeItems({int? page, int? limit});
  FutureEither<HomeEntity> getHomeItemById(String id);
  FutureEither<Unit> bookmarkItem(String id);
  FutureEither<Unit> removeBookmark(String id);
  FutureEither<List<HomeEntity>> getCachedItems();
}
