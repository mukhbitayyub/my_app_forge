import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app_forge/core/di/injection.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_bloc.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_event.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_state.dart';
import 'package:my_app_forge/core/permissions/permission_type.dart';
import 'package:my_app_forge/shared/widgets/app_loading.dart';

/// PermissionGuard widget protects screens that require runtime permissions.
///
/// Usage example:
/// ```dart
/// PermissionGuard(
///   permission: AppPermission.camera,
///   child: CameraView(),
///   deniedWidget: PermissionDeniedView(permission: AppPermission.camera),
///   permanentlyDeniedWidget: OpenSettingsView(),
/// )
/// ```
class PermissionGuard extends StatelessWidget {
  const PermissionGuard({
    required this.permission,
    required this.child,
    required this.deniedWidget,
    required this.permanentlyDeniedWidget,
    this.autoRequest = true,
    super.key,
  });

  final AppPermission permission;
  final Widget child;
  final Widget deniedWidget;
  final Widget permanentlyDeniedWidget;
  final bool autoRequest;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PermissionBloc>(
      create: (context) {
        final bloc = getIt<PermissionBloc>();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (autoRequest) {
            bloc.add(PermissionRequestStarted(permission));
          } else {
            bloc.add(PermissionCheckRequested(permission));
          }
        });
        return bloc;
      },
      child: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          return switch (state) {
            PermissionInitial() || PermissionChecking() => const AppLoading(),
            PermissionGranted() => child,
            PermissionDenied() => deniedWidget,
            PermissionPermanentlyDenied() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  permanentlyDeniedWidget,
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<PermissionBloc>()
                          .add(const PermissionSettingsOpened());
                    },
                    child: const Text('Open Settings'),
                  ),
                ],
              ),
            PermissionMultipleResult() || PermissionError() => deniedWidget,
          };
        },
      ),
    );
  }
}
