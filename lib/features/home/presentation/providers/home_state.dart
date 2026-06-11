import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeData with _$HomeData {
  const factory HomeData({
    required List<HomeEntity> items,
    required int currentPage,
    required bool hasMore,
    required bool isRefreshing,
  }) = _HomeData;

  factory HomeData.initial() => const HomeData(
        items: [],
        currentPage: 1,
        hasMore: true,
        isRefreshing: false,
      );
}
