import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_forge/core/router/app_routes.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class HomeActionGrid extends StatelessWidget {
  const HomeActionGrid({required this.isDark, super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.w,
      mainAxisSpacing: 16.h,
      childAspectRatio: 1.3,
      children: [
        _buildGridItem(
          icon: Icons.article_outlined,
          title: 'View Details',
          subtitle: 'Item properties',
          onTap: () => context.push(AppRoutes.detailPath),
          isDark: isDark,
        ),
        _buildGridItem(
          icon: Icons.settings_outlined,
          title: 'Settings',
          subtitle: 'Adjust app options',
          onTap: () => context.push(AppRoutes.settingsPath),
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildGridItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 24.r),
              SizedBox(height: 8.h),
              Text(
                title,
                style: isDark ? AppTextStyles.darkBodyLargeBold : AppTextStyles.bodyLargeBold,
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: isDark ? AppTextStyles.darkLabelSmall : AppTextStyles.labelSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
