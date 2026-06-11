import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';

class AppEmptyView extends StatelessWidget {
  const AppEmptyView({
    required this.message,
    this.subMessage,
    this.icon,
    this.onAction,
    this.actionLabel,
    super.key,
  });

  final String message;
  final String? subMessage;
  final Widget? icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? Icon(
              Icons.inbox_outlined,
              color: AppColors.grey,
              size: 48.r,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: AppTextStyles.bodyLargeBold,
              textAlign: TextAlign.center,
            ),
            if (subMessage != null) ...[
              SizedBox(height: 8.h),
              Text(
                subMessage!,
                style: AppTextStyles.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            if (onAction != null && actionLabel != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
