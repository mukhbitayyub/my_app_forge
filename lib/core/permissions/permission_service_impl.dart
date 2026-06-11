import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/permissions/permission_service.dart';
import 'package:my_app_forge/core/permissions/permission_type.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

@LazySingleton(as: PermissionService)
class PermissionServiceImpl implements PermissionService {
  @override
  Future<ph.PermissionStatus> checkPermission(AppPermission permission) async {
    try {
      return await permission.handler.status;
    } on PlatformException {
      return ph.PermissionStatus.denied;
    }
  }

  @override
  Future<ph.PermissionStatus> requestPermission(AppPermission permission) async {
    try {
      return await permission.handler.request();
    } on PlatformException {
      return ph.PermissionStatus.denied;
    }
  }

  @override
  Future<Map<AppPermission, ph.PermissionStatus>> requestMultiple(
    List<AppPermission> permissions,
  ) async {
    try {
      final handlers = permissions.map((p) => p.handler).toList();
      final results = await ph.PermissionListActions(handlers).request();
      return permissions.fold<Map<AppPermission, ph.PermissionStatus>>(
        {},
        (map, p) {
          map[p] = results[p.handler] ?? ph.PermissionStatus.denied;
          return map;
        },
      );
    } on PlatformException {
      return permissions.fold<Map<AppPermission, ph.PermissionStatus>>(
        {},
        (map, p) {
          map[p] = ph.PermissionStatus.denied;
          return map;
        },
      );
    }
  }

  @override
  Future<bool> openAppSettings() async {
    try {
      return await ph.openAppSettings();
    } on PlatformException {
      return false;
    }
  }
}
