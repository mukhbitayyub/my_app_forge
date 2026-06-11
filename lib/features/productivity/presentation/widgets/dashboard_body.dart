import 'package:flutter/material.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/dashboard_error_view.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/dashboard_loaded_view.dart';
import 'package:my_app_forge/shared/widgets/app_loading.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({
    required this.stateNotifier,
    required this.onRetry,
    super.key,
  });

  final ValueNotifier<String> stateNotifier;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: stateNotifier,
      builder: (context, state, child) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: switch (state) {
            'loading' => const Center(
                key: ValueKey('loading'),
                child: AppLoading(),
              ),
            'error' => DashboardErrorView(
                key: const ValueKey('error'),
                onRetry: onRetry,
              ),
            _ => const DashboardLoadedView(
                key: ValueKey('loaded'),
              ),
          },
        );
      },
    );
  }
}
