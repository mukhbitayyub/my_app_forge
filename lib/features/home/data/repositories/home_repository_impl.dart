import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/error/error_handler.dart';
import 'package:my_app_forge/core/error/failures.dart';
import 'package:my_app_forge/core/network/network_info.dart';
import 'package:my_app_forge/core/usecase/usecase.dart';
import 'package:my_app_forge/features/home/data/datasources/home_local_datasource.dart';
import 'package:my_app_forge/features/home/data/datasources/home_remote_datasource.dart';
import 'package:my_app_forge/features/home/data/models/home_model.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';
import 'package:my_app_forge/features/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._networkInfo,
  );

  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  FutureEither<List<HomeEntity>> getHomeItems({int? page, int? limit}) async {
    try {
      final isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final remoteItems = await _remoteDataSource.getHomeItems(page: page, limit: limit);
        await _localDataSource.cacheHomeItems(remoteItems);
        return Right(remoteItems);
      } else {
        final cachedItems = await _localDataSource.getCachedHomeItems();
        if (cachedItems.isNotEmpty) {
          return Right(cachedItems);
        }
        return const Left(NetworkFailure());
      }
    } on Object catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  FutureEither<HomeEntity> getHomeItemById(String id) async {
    try {
      final item = await _remoteDataSource.getHomeItemById(id);
      return Right(item);
    } on Object catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  FutureEither<Unit> bookmarkItem(String id) async {
    try {
      await _remoteDataSource.bookmarkItem(id);
      final cachedItems = await _localDataSource.getCachedHomeItems();
      if (cachedItems.isNotEmpty) {
        final updated = cachedItems.map((item) {
          if (item.id == id) {
            return HomeModel(
              id: item.id,
              title: item.title,
              description: item.description,
              imageUrl: item.imageUrl,
              createdAt: item.createdAt,
              isBookmarked: true,
            );
          }
          return item;
        }).toList();
        await _localDataSource.cacheHomeItems(updated);
      }
      return const Right(unit);
    } on Object catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  FutureEither<Unit> removeBookmark(String id) async {
    try {
      await _remoteDataSource.removeBookmark(id);
      final cachedItems = await _localDataSource.getCachedHomeItems();
      if (cachedItems.isNotEmpty) {
        final updated = cachedItems.map((item) {
          if (item.id == id) {
            return HomeModel(
              id: item.id,
              title: item.title,
              description: item.description,
              imageUrl: item.imageUrl,
              createdAt: item.createdAt,
              isBookmarked: false,
            );
          }
          return item;
        }).toList();
        await _localDataSource.cacheHomeItems(updated);
      }
      return const Right(unit);
    } on Object catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  FutureEither<List<HomeEntity>> getCachedItems() async {
    try {
      final cached = await _localDataSource.getCachedHomeItems();
      return Right(cached);
    } on Object catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
