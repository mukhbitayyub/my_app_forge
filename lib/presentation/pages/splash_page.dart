import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/router/app_routes.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/shared/widgets/app_loading.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    unawaited(_navigateToNext());
  }

  Future<void> _navigateToNext() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final isLoggedIn = getIt<ValueNotifier<bool>>().value;
    if (isLoggedIn) {
      context.go(AppRoutes.homePath);
    } else {
      context.go(AppRoutes.onboardingPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.darkBackground, AppColors.darkSurface]
                : [AppColors.lightBackground, AppColors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100.r,
                height: 100.r,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.layers_outlined,
                  size: 48.r,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Dart Blueprint',
                style: isDark
                    ? AppTextStyles.darkDisplayLargeBold
                    : AppTextStyles.displayLargeBold,
              ),
              SizedBox(height: 8.h),
              Text(
                'Enterprise Clean Architecture',
                style: isDark
                    ? AppTextStyles.darkLabelLarge
                    : AppTextStyles.labelLarge,
              ),
              SizedBox(height: 48.h),
              const AppLoading(size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
