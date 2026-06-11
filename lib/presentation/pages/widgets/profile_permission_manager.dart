import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_bloc.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_event.dart';
import 'package:my_app_forge/core/permissions/permission_type.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/core/theme/app_text_styles.dart';
import 'package:my_app_forge/shared/widgets/app_button.dart';

class ProfilePermissionManager extends StatelessWidget {
  const ProfilePermissionManager({required this.isDark, super.key});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hardware Permissions',
              style: isDark ? AppTextStyles.darkTitleMediumBold : AppTextStyles.titleMediumBold,
            ),
            SizedBox(height: 8.h),
            Text(
              'Test the PermissionBloc integration directly using these request triggers.',
              style: isDark ? AppTextStyles.darkBodySmall : AppTextStyles.bodySmall,
            ),
            SizedBox(height: 20.h),
            _buildPermissionTile(
              context,
              icon: Icons.camera_alt_outlined,
              title: 'Camera Access',
              permission: AppPermission.camera,
              isDark: isDark,
            ),
            const Divider(),
            _buildPermissionTile(
              context,
              icon: Icons.mic_none_outlined,
              title: 'Microphone Access',
              permission: AppPermission.microphone,
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required AppPermission permission,
    required bool isDark,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primaryColor, size: 24.r),
      title: Text(
        title,
        style: isDark ? AppTextStyles.darkBodyMediumBold : AppTextStyles.bodyMediumBold,
      ),
      trailing: AppButton(
        label: 'Request',
        width: 80.w,
        height: 36.h,
        onPressed: () {
          context.read<PermissionBloc>().add(PermissionRequestStarted(permission));
        },
      ),
    );
  }
}
