import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class TaskPrioritySelector extends StatelessWidget {
  const TaskPrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  final String selectedPriority;
  final ValueChanged<String> onPriorityChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ['Low', 'Medium', 'High'].map((p) {
        final isSelected = selectedPriority == p;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: InkWell(
              onTap: () => onPriorityChanged(p),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected ? AppColors.primaryColor : AppColors.surface,
                    width: 1.w,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  p,
                  style: AppTextStyles.bodyMediumBold.copyWith(
                    color: isSelected ? AppColors.white : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
