import 'package:my_app_forge/core/permissions/permission_type.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionService {
  Future<PermissionStatus> checkPermission(AppPermission permission);

  Future<PermissionStatus> requestPermission(AppPermission permission);

  Future<Map<AppPermission, PermissionStatus>> requestMultiple(
    List<AppPermission> permissions,
  );

  Future<bool> openAppSettings();
}
