import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class TaskDateField extends StatelessWidget {
  const TaskDateField({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  final DateTime? selectedDate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.surface, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? 'Select Due Date'
                  : DateFormat('EEE, MMM d, yyyy').format(selectedDate!),
              style: AppTextStyles.bodyMedium.copyWith(
                color: selectedDate == null
                    ? AppColors.grey
                    : AppColors.lightTextPrimary,
              ),
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: AppColors.primaryColor,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
