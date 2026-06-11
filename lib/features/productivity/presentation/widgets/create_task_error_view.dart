import 'package:flutter/material.dart';
import 'package:my_app_forge/shared/widgets/app_error_view.dart';

class CreateTaskErrorView extends StatelessWidget {
  const CreateTaskErrorView({
    required this.onRetry,
    super.key,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppErrorView(
      message: 'Failed to initialize the form. Please try again.',
      onRetry: onRetry,
    );
  }
}
