import 'package:equatable/equatable.dart';
import 'package:my_app_forge/core/error/failures.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeRefreshing extends HomeState {
  const HomeRefreshing(this.currentItems);
  final List<HomeEntity> currentItems;

  @override
  List<Object?> get props => [currentItems];
}

class HomeSuccess extends HomeState {
  const HomeSuccess({
    required this.items,
    required this.currentPage,
    required this.hasMore,
  });

  final List<HomeEntity> items;
  final int currentPage;
  final bool hasMore;

  @override
  List<Object?> get props => [items, currentPage, hasMore];
}

class HomeFailure extends HomeState {
  const HomeFailure({
    required this.failure,
    this.cachedItems,
  });

  final Failure failure;
  final List<HomeEntity>? cachedItems;

  @override
  List<Object?> get props => [failure, cachedItems];
}

class HomeBookmarkUpdated extends HomeState {
  const HomeBookmarkUpdated(this.itemId, {required this.isBookmarked});
  final String itemId;
  final bool isBookmarked;

  @override
  List<Object?> get props => [itemId, isBookmarked];
}
