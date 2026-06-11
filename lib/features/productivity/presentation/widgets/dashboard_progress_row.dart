import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class DashboardProgressRow extends StatelessWidget {
  const DashboardProgressRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 140.h,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.04),
                  blurRadius: 8.r,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: CircularProgressIndicator(
                        value: 0.75,
                        strokeWidth: 8.r,
                        backgroundColor: AppColors.grey.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryColor,
                        ),
                      ),
                    ),
                    Text('75%', style: AppTextStyles.titleMediumBold),
                  ],
                ),
                SizedBox(height: 10.h),
                Text('Completed Today', style: AppTextStyles.labelSmallBold),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _buildSummaryTile(
                'Active Tasks',
                '12',
                AppColors.info,
                Icons.playlist_add_check_rounded,
              ),
              SizedBox(height: 10.h),
              _buildSummaryTile(
                'Completed',
                '36',
                AppColors.success,
                Icons.task_alt_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryTile(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 6.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22.r),
          SizedBox(width: 12.w),
          Expanded(child: Text(label, style: AppTextStyles.bodyMediumBold)),
          Text(
            value,
            style: AppTextStyles.titleMediumBold.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
