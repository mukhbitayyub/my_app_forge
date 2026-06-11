import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class OnboardingSlideView extends StatelessWidget {
  const OnboardingSlideView({
    required this.title,
    required this.desc,
    required this.icon,
    required this.isDark,
    super.key,
  });

  final String title;
  final String desc;
  final String icon;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 160.r,
          height: 160.r,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon == 'architecture'
                ? Icons.layers_outlined
                : icon == 'verified_user'
                    ? Icons.verified_user_outlined
                    : Icons.palette_outlined,
            size: 80.r,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: isDark
              ? AppTextStyles.darkHeadlineLargeBold
              : AppTextStyles.headlineLargeBold,
        ),
        SizedBox(height: 16.h),
        Text(
          desc,
          textAlign: TextAlign.center,
          style: isDark
              ? AppTextStyles.darkLabelLarge
              : AppTextStyles.labelLarge,
        ),
      ],
    );
  }
}
