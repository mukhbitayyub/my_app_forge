import 'package:equatable/equatable.dart';
import 'package:my_app_forge/core/permissions/permission_type.dart';
import 'package:permission_handler/permission_handler.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object?> get props => [];
}

class PermissionInitial extends PermissionState {
  const PermissionInitial();
}

class PermissionChecking extends PermissionState {
  const PermissionChecking();
}

class PermissionGranted extends PermissionState {
  const PermissionGranted(this.permission);
  final AppPermission permission;

  @override
  List<Object?> get props => [permission];
}

class PermissionDenied extends PermissionState {
  const PermissionDenied(this.permission);
  final AppPermission permission;

  @override
  List<Object?> get props => [permission];
}

class PermissionPermanentlyDenied extends PermissionState {
  const PermissionPermanentlyDenied(this.permission);
  final AppPermission permission;

  @override
  List<Object?> get props => [permission];
}

class PermissionMultipleResult extends PermissionState {
  const PermissionMultipleResult(this.results);
  final Map<AppPermission, PermissionStatus> results;

  @override
  List<Object?> get props => [results];
}

class PermissionError extends PermissionState {
  const PermissionError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
