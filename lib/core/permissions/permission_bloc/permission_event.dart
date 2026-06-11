import 'package:equatable/equatable.dart';
import 'package:my_app_forge/core/permissions/permission_type.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object?> get props => [];
}

class PermissionCheckRequested extends PermissionEvent {
  const PermissionCheckRequested(this.permission);
  final AppPermission permission;

  @override
  List<Object?> get props => [permission];
}

class PermissionRequestStarted extends PermissionEvent {
  const PermissionRequestStarted(this.permission);
  final AppPermission permission;

  @override
  List<Object?> get props => [permission];
}

class PermissionMultipleRequested extends PermissionEvent {
  const PermissionMultipleRequested(this.permissions);
  final List<AppPermission> permissions;

  @override
  List<Object?> get props => [permissions];
}

class PermissionSettingsOpened extends PermissionEvent {
  const PermissionSettingsOpened();
}
