import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onDismissed,
  });

  final Map<String, dynamic> task;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task['id'] as String),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed(),
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: AppColors.success,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Complete',
              style: AppTextStyles.bodyMediumBold.copyWith(color: AppColors.white),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.check_circle_outline_rounded, color: AppColors.white, size: 24.r),
          ],
        ),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: AppColors.surface, width: 1.w),
        ),
        color: AppColors.lightSurface,
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Row(
            children: [
              _buildCategoryIcon(task['category'] as String),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task['title'] as String, style: AppTextStyles.bodyLargeBold),
                    SizedBox(height: 4.h),
                    Text(task['category'] as String, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              _buildPriorityBadge(task['priority'] as String),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String category) {
    final iconData = switch (category) {
      'Work' => Icons.work_outline_rounded,
      'Health' => Icons.favorite_border_rounded,
      'Personal' => Icons.person_outline_rounded,
      _ => Icons.star_border_rounded,
    };
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, color: AppColors.primaryColor, size: 20.r),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    final (bgColor, textColor) = switch (priority) {
      'High' => (AppColors.error.withValues(alpha: 0.1), AppColors.error),
      'Medium' => (AppColors.warning.withValues(alpha: 0.1), AppColors.warning),
      _ => (AppColors.info.withValues(alpha: 0.1), AppColors.info),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        priority,
        style: AppTextStyles.labelSmallBold.copyWith(color: textColor),
      ),
    );
  }
}
