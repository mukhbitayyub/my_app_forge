import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/usecase/usecase.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';
import 'package:my_app_forge/features/home/domain/usecases/bookmark_item_usecase.dart';
import 'package:my_app_forge/features/home/domain/usecases/get_cached_items_usecase.dart';
import 'package:my_app_forge/features/home/domain/usecases/get_home_items_usecase.dart';
import 'package:my_app_forge/features/home/presentation/cubit/home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getHomeItemsUseCase,
    this._getCachedItemsUseCase,
    this._bookmarkItemUseCase,
  ) : super(const HomeInitial());

  final GetHomeItemsUseCase _getHomeItemsUseCase;
  final GetCachedItemsUseCase _getCachedItemsUseCase;
  final BookmarkItemUseCase _bookmarkItemUseCase;

  Future<void> loadItems() async {
    emit(const HomeLoading());
    final result = await _getHomeItemsUseCase(const GetHomeItemsParams(page: 1, limit: 10));
    if (result.isLeft()) {
      final failure = result.fold((l) => l, (r) => throw Exception());
      final cachedResult = await _getCachedItemsUseCase(const NoParams());
      final cachedItems = cachedResult.getOrElse(() => []);
      emit(HomeFailure(
        failure: failure,
        cachedItems: cachedItems.isEmpty ? null : cachedItems,
      ));
    } else {
      final items = result.getOrElse(() => []);
      emit(HomeSuccess(items: items, currentPage: 1, hasMore: items.length >= 10));
    }
  }

  Future<void> refresh() async {
    final currentItems = state is HomeSuccess ? (state as HomeSuccess).items : <HomeEntity>[];
    emit(HomeRefreshing(currentItems));
    final result = await _getHomeItemsUseCase(const GetHomeItemsParams(page: 1, limit: 10));
    result.fold(
      (failure) => emit(HomeFailure(failure: failure, cachedItems: currentItems)),
      (items) => emit(HomeSuccess(items: items, currentPage: 1, hasMore: items.length >= 10)),
    );
  }

  Future<void> loadMore() async {
    if (state is! HomeSuccess) return;
    final currentState = state as HomeSuccess;
    if (!currentState.hasMore) return;

    final nextPage = currentState.currentPage + 1;
    final result = await _getHomeItemsUseCase(GetHomeItemsParams(page: nextPage, limit: 10));
    result.fold(
      (failure) => emit(HomeFailure(failure: failure, cachedItems: currentState.items)),
      (items) {
        emit(HomeSuccess(
          items: List.of(currentState.items)..addAll(items),
          currentPage: nextPage,
          hasMore: items.length >= 10,
        ));
      },
    );
  }

  Future<void> bookmarkItem(String id) async {
    final result = await _bookmarkItemUseCase(id);
    result.fold(
      (_) {},
      (_) {
        if (state is HomeSuccess) {
          final currentState = state as HomeSuccess;
          var isBookmarked = false;
          final updatedItems = currentState.items.map((item) {
            if (item.id == id) {
              isBookmarked = !item.isBookmarked;
              return HomeEntity(
                id: item.id,
                title: item.title,
                description: item.description,
                imageUrl: item.imageUrl,
                createdAt: item.createdAt,
                isBookmarked: isBookmarked,
              );
            }
            return item;
          }).toList();
          emit(HomeBookmarkUpdated(id, isBookmarked: isBookmarked));
          emit(HomeSuccess(
            items: updatedItems,
            currentPage: currentState.currentPage,
            hasMore: currentState.hasMore,
          ));
        }
      },
    );
  }
}
