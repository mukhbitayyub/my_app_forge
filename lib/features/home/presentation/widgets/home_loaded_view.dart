import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_event.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_state.dart';
import 'package:my_app_forge/features/home/presentation/widgets/home_item_card.dart';
import 'package:my_app_forge/shared/widgets/app_shimmer.dart';

class HomeLoadedView extends StatelessWidget {
  const HomeLoadedView({
    required this.items,
    this.isRefreshing = false,
    super.key,
  });

  final List<HomeEntity> items;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    final hasMore = state is HomeSuccess && state.hasMore;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          final metrics = notification.metrics;
          if (metrics.pixels >= metrics.maxScrollExtent - 200.h) {
            final currentState = context.read<HomeBloc>().state;
            if (currentState is HomeSuccess && currentState.hasMore) {
              context.read<HomeBloc>().add(
                    HomePageChanged(currentState.currentPage + 1),
                  );
            }
          }
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(const HomeRefreshRequested());
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.r),
          itemCount: items.length + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == items.length) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Center(
                  child: AppShimmer(
                    width: double.infinity,
                    height: 100.h,
                    radius: 12.r,
                  ),
                ),
              );
            }

            final item = items[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: HomeItemCard(
                item: item,
                onTap: () {},
                onBookmark: () {
                  context.read<HomeBloc>().add(HomeItemBookmarked(item.id));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
