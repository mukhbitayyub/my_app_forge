import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/shared/widgets/app_loading.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.width,
    this.height = 52,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final double? width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    final resolvedBgColor = backgroundColor ?? AppColors.primaryColor;

    final textStyle = AppTextStyles.titleMediumBold.copyWith(
      color: isOutlined ? resolvedBgColor : AppColors.white,
    );

    final childWidget = isLoading
        ? AppLoading(
            size: 20.r,
            color: isOutlined ? resolvedBgColor : AppColors.white,
          )
        : Text(label, style: textStyle);

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: isOutlined ? Colors.transparent : resolvedBgColor,
      foregroundColor: isOutlined ? resolvedBgColor : AppColors.white,
      disabledBackgroundColor:
          isOutlined ? Colors.transparent : AppColors.grey.withValues(alpha: 0.3),
      disabledForegroundColor: AppColors.grey,
      minimumSize: Size(width ?? double.infinity, height.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: isOutlined
            ? BorderSide(
                color: disabled ? AppColors.grey : resolvedBgColor,
                width: 1.5.w,
              )
            : BorderSide.none,
      ),
      elevation: isOutlined ? 0 : null,
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height.h,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: buttonStyle,
        child: childWidget,
      ),
    );
  }
}
