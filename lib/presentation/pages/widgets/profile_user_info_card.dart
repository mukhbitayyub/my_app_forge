import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/shared/widgets/app_network_image.dart';

class ProfileUserInfoCard extends StatelessWidget {
  const ProfileUserInfoCard({required this.isDark, super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Row(
          children: [
            AppNetworkImage(
              url: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&h=200&fit=crop',
              width: 64.r,
              height: 64.r,
              radius: 32.r,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jane Doe',
                    style: isDark ? AppTextStyles.darkTitleLargeBold : AppTextStyles.titleLargeBold,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'jane.doe@agency.com',
                    style: isDark ? AppTextStyles.darkBodySmall : AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
