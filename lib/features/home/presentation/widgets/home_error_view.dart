import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/error/failures.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/features/home/domain/entities/home_entity.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_bloc.dart';
import 'package:my_app_forge/features/home/presentation/bloc/home_event.dart';
import 'package:my_app_forge/features/home/presentation/widgets/home_loaded_view.dart';
import 'package:my_app_forge/shared/widgets/app_error_view.dart';

class HomeErrorView extends StatelessWidget {
  const HomeErrorView({required this.failure, this.cachedItems, super.key});
  final Failure failure;
  final List<HomeEntity>? cachedItems;

  @override
  Widget build(BuildContext context) {
    final hasCache = cachedItems != null && cachedItems!.isNotEmpty;
    if (!hasCache) {
      return AppErrorView(
        message: failure.userMessage,
        onRetry: () => context.read<HomeBloc>().add(const HomeStarted()),
      );
    }

    return Column(
      children: [
        Container(
          color: AppColors.error.withValues(alpha: 0.1),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            children: [
              Icon(Icons.wifi_off_rounded, color: AppColors.error, size: 20.r),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Showing offline/cached data.',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.error, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => context.read<HomeBloc>().add(const HomeStarted()),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        Expanded(child: HomeLoadedView(items: cachedItems!)),
      ],
    );
  }
}
