import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_bloc.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_event.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_state.dart';
import 'package:my_app_forge/core/router/app_routes.dart';
import 'package:my_app_forge/core/theme/app_colors.dart';
import 'package:my_app_forge/presentation/pages/widgets/profile_permission_manager.dart';
import 'package:my_app_forge/presentation/pages/widgets/profile_user_info_card.dart';
import 'package:my_app_forge/shared/widgets/app_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider<PermissionBloc>(
      create: (_) => getIt<PermissionBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<PermissionBloc, PermissionState>(
            listener: (context, state) {
              if (state is PermissionGranted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.permission.name.toUpperCase()} Permission GRANTED'),
                    backgroundColor: AppColors.success,
                  ),
                );
              } else if (state is PermissionDenied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.permission.name.toUpperCase()} Permission DENIED'),
                    backgroundColor: AppColors.error,
                  ),
                );
              } else if (state is PermissionPermanentlyDenied) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.permission.name.toUpperCase()} permanently denied. Open settings.'),
                    action: SnackBarAction(
                      label: 'Settings',
                      textColor: AppColors.white,
                      onPressed: () {
                        context.read<PermissionBloc>().add(const PermissionSettingsOpened());
                      },
                    ),
                    backgroundColor: AppColors.warning,
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(24.r),
                child: Column(
                  children: [
                    ProfileUserInfoCard(isDark: isDark),
                    SizedBox(height: 24.h),
                    ProfilePermissionManager(isDark: isDark),
                    SizedBox(height: 32.h),
                    AppButton(
                      label: 'Logout',
                      isOutlined: true,
                      onPressed: () {
                        getIt<ValueNotifier<bool>>().value = false;
                        context.go(AppRoutes.onboardingPath);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
