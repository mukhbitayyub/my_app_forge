import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/dashboard_progress_row.dart';
import 'package:my_app_forge/features/productivity/presentation/widgets/streak_counter_card.dart';

class DashboardLoadedView extends StatelessWidget {
  const DashboardLoadedView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StreakCounterCard(),
          SizedBox(height: 20.h),
          Text("Today's Overview", style: AppTextStyles.titleLargeBold),
          SizedBox(height: 12.h),
          const DashboardProgressRow(),
          SizedBox(height: 24.h),
          Text('Focus Categories', style: AppTextStyles.titleLargeBold),
          SizedBox(height: 12.h),
          _buildCategoryGrid(),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.4,
      children: [
        _buildCategoryCard(
          'Work',
          '8 tasks',
          AppColors.primaryColor,
          Icons.work_outline_rounded,
        ),
        _buildCategoryCard(
          'Personal',
          '3 tasks',
          AppColors.secondaryColor,
          Icons.person_outline_rounded,
        ),
        _buildCategoryCard(
          'Health',
          '4 tasks',
          AppColors.success,
          Icons.favorite_border_rounded,
        ),
        _buildCategoryCard(
          'Finance',
          '1 task',
          AppColors.info,
          Icons.monetization_on_outlined,
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    String name,
    String count,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 24.r),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.titleMediumBold),
              SizedBox(height: 2.h),
              Text(count, style: AppTextStyles.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
