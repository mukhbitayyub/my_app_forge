import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_state.dart';
import 'package:my_app_forge/features/home/presentation/widgets/home_error_view.dart';
import 'package:my_app_forge/features/home/presentation/widgets/home_loaded_view.dart';
import 'package:my_app_forge/shared/widgets/app_loading.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => current is! HomeBookmarkUpdated,
      builder: (context, state) {
        return switch (state) {
          HomeInitial() || HomeLoading() => const Center(
              child: AppLoading(),
            ),
          HomeRefreshing(:final currentItems) => HomeLoadedView(
              items: currentItems,
              isRefreshing: true,
            ),
          HomeSuccess(:final items) => HomeLoadedView(
              items: items,
            ),
          HomeFailure(:final failure, :final cachedItems) => HomeErrorView(
              failure: failure,
              cachedItems: cachedItems,
            ),
          HomeBookmarkUpdated() => const SizedBox.shrink(),
        };
      },
    );
  }
}
