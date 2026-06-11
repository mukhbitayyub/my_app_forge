import 'package:flutter/material.dart';
import 'package:my_app_forge/shared/widgets/app_error_view.dart';

class DashboardErrorView extends StatelessWidget {
  const DashboardErrorView({
    required this.onRetry,
    super.key,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppErrorView(
      message: 'Failed to load your productivity data. Please check your connection and try again.',
      onRetry: onRetry,
    );
  }
}
