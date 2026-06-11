import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/router/app_routes.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/presentation/pages/widgets/onboarding_slide_view.dart';
import 'package:my_app_forge/shared/widgets/app_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Clean Architecture',
      'desc': 'Separation of concerns using Domain-Driven Design, BLoC pattern, and Dependency Injection.',
      'icon': 'architecture',
    },
    {
      'title': 'Production Ready',
      'desc': 'Pre-configured HTTP client (Dio), local persistence, and offline connection status trackers.',
      'icon': 'verified_user',
    },
    {
      'title': 'Stunning UI',
      'desc': 'Responsive scaling via ScreenUtil, robust design system tokens, and sleek dark mode support.',
      'icon': 'palette',
    },
  ];

  void _onGetStarted() {
    getIt<ValueNotifier<bool>>().value = true;
    context.go(AppRoutes.homePath);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _onGetStarted,
                  child: Text(
                    'Skip',
                    style: AppTextStyles.bodyMediumBold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return OnboardingSlideView(
                      title: slide['title']!,
                      desc: slide['desc']!,
                      icon: slide['icon']!,
                      isDark: isDark,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: _currentPage == index ? 24.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.primaryColor
                          : AppColors.grey.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              AppButton(
                label: _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                onPressed: () {
                  if (_currentPage < _slides.length - 1) {
                    unawaited(
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                    );
                  } else {
                    _onGetStarted();
                  }
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
