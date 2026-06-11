import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/network/network_info.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class NetworkStatusCard extends StatelessWidget {
  const NetworkStatusCard({required this.isDark, super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: getIt<NetworkInfo>().onConnectivityChanged,
      builder: (context, snapshot) {
        final isConnected = snapshot.data ?? true;
        return Card(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: BoxDecoration(
                    color: (isConnected ? AppColors.success : AppColors.error).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isConnected ? Icons.wifi : Icons.wifi_off,
                    color: isConnected ? AppColors.success : AppColors.error,
                    size: 22.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Network Connection',
                        style: isDark ? AppTextStyles.darkTitleMediumBold : AppTextStyles.titleMediumBold,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        isConnected ? 'You are currently online' : 'You are offline',
                        style: isDark ? AppTextStyles.darkBodySmall : AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 10.r,
                  height: 10.r,
                  decoration: BoxDecoration(
                    color: isConnected ? AppColors.success : AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
