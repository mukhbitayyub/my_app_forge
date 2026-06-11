import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/shared/widgets/app_button.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Resource Detail'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(isDark),
            SizedBox(height: 24.h),
            Text(
              'Technical Specifications',
              style: isDark ? AppTextStyles.darkTitleLargeBold : AppTextStyles.titleLargeBold,
            ),
            SizedBox(height: 16.h),
            _buildSpecTable(isDark),
            SizedBox(height: 32.h),
            AppButton(
              label: 'Acknowledge Specification',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Specification acknowledged successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner(bool isDark) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.terminal_outlined, color: AppColors.primaryColor, size: 32.r),
              SizedBox(width: 12.w),
              Text(
                'FVM & Flutter 3.44.1',
                style: isDark ? AppTextStyles.darkTitleLargeBold : AppTextStyles.titleLargeBold,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'This blueprint specifies a strict Clean Architecture pattern using Dart 3.12 syntax guidelines. Files are limited to 150 lines with fully segregated dependency chains.',
            style: isDark ? AppTextStyles.darkBodyMedium : AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecTable(bool isDark) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            _buildSpecRow('Structure', 'Feature-first Clean architecture', isDark, isLast: false),
            _buildSpecRow('State Managers', 'BLoC Pattern & Riverpod annotations', isDark, isLast: false),
            _buildSpecRow('DI Engine', 'GetIt & Injectable auto-generators', isDark, isLast: false),
            _buildSpecRow('Responsive System', 'ScreenUtil scale wrappers (.w .h .sp .r)', isDark, isLast: false),
            _buildSpecRow('Linter Rule set', 'very_good_analysis strict presets', isDark, isLast: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String key, String value, bool isDark, {required bool isLast}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key,
                style: isDark ? AppTextStyles.darkBodyMediumBold : AppTextStyles.bodyMediumBold,
              ),
              const Spacer(),
              Expanded(
                flex: 2,
                child: Text(
                  value,
                  style: isDark ? AppTextStyles.darkBodyMedium : AppTextStyles.bodyMedium,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          if (!isLast) ...[
            SizedBox(height: 4.h),
            const Divider(height: 1),
          ],
        ],
      ),
    );
  }
}
