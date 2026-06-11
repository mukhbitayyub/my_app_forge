import 'dart:async';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';
import 'package:my_app_forge/features/home/domain/usecases/bookmark_item_usecase.dart';
import 'package:my_app_forge/features/home/domain/usecases/get_home_items_usecase.dart';
import 'package:my_app_forge/features/home/presentation/providers/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  @override
  FutureOr<HomeData> build() async {
    return _loadItems(page: 1);
  }

  Future<HomeData> _loadItems({required int page}) async {
    final useCase = getIt<GetHomeItemsUseCase>();
    final result = await useCase(GetHomeItemsParams(page: page, limit: 10));
    return result.fold(
      (failure) => throw failure,
      (items) => HomeData(
        items: items,
        currentPage: page,
        hasMore: items.length >= 10,
        isRefreshing: false,
      ),
    );
  }

  Future<void> refresh() async {
    final currentState = state.value ?? HomeData.initial();
    state = AsyncValue.data(currentState.copyWith(isRefreshing: true));
    try {
      final newData = await _loadItems(page: 1);
      state = AsyncValue.data(newData);
    } on Object catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> loadMore() async {
    final currentState = state.value;
    if (currentState == null || !currentState.hasMore || state.isLoading) return;

    final nextPage = currentState.currentPage + 1;
    state = const AsyncValue.loading();
    try {
      final useCase = getIt<GetHomeItemsUseCase>();
      final result = await useCase(GetHomeItemsParams(page: nextPage, limit: 10));
      result.fold(
        (failure) => throw failure,
        (items) {
          state = AsyncValue.data(currentState.copyWith(
            items: List.of(currentState.items)..addAll(items),
            currentPage: nextPage,
            hasMore: items.length >= 10,
          ));
        },
      );
    } on Object catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> bookmarkItem(String id) async {
    final useCase = getIt<BookmarkItemUseCase>();
    final result = await useCase(id);
    result.fold(
      (_) {},
      (_) {
        final currentState = state.value;
        if (currentState != null) {
          final updatedItems = currentState.items.map((item) {
            if (item.id == id) {
              return HomeEntity(
                id: item.id,
                title: item.title,
                description: item.description,
                imageUrl: item.imageUrl,
                createdAt: item.createdAt,
                isBookmarked: !item.isBookmarked,
              );
            }
            return item;
          }).toList();
          state = AsyncValue.data(currentState.copyWith(items: updatedItems));
        }
      },
    );
  }
}
