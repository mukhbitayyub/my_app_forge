import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_event.dart';
import 'package:my_app_forge/core/permissions/permission_bloc/permission_state.dart';
import 'package:my_app_forge/core/permissions/permission_service.dart';
import 'package:my_app_forge/core/permissions/permission_type.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc(this._service) : super(const PermissionInitial()) {
    on<PermissionCheckRequested>(_onCheck);
    on<PermissionRequestStarted>(_onRequest);
    on<PermissionMultipleRequested>(_onMultiple);
    on<PermissionSettingsOpened>(_onSettings);
  }

  final PermissionService _service;
  AppPermission? _currentPermission;

  Future<void> _onCheck(
    PermissionCheckRequested event,
    Emitter<PermissionState> emit,
  ) async {
    _currentPermission = event.permission;
    emit(const PermissionChecking());
    try {
      final status = await _service.checkPermission(event.permission);
      emit(_mapStatusToState(event.permission, status));
    } on PlatformException catch (e) {
      emit(PermissionError('Platform error checking permission: ${e.message}'));
    } on Object catch (e) {
      emit(PermissionError('Unexpected error checking permission: $e'));
    }
  }

  Future<void> _onRequest(
    PermissionRequestStarted event,
    Emitter<PermissionState> emit,
  ) async {
    _currentPermission = event.permission;
    emit(const PermissionChecking());
    try {
      final status = await _service.requestPermission(event.permission);
      emit(_mapStatusToState(event.permission, status));
    } on PlatformException catch (e) {
      emit(PermissionError('Platform error requesting permission: ${e.message}'));
    } on Object catch (e) {
      emit(PermissionError('Unexpected error requesting permission: $e'));
    }
  }

  Future<void> _onMultiple(
    PermissionMultipleRequested event,
    Emitter<PermissionState> emit,
  ) async {
    emit(const PermissionChecking());
    try {
      final results = await _service.requestMultiple(event.permissions);
      emit(PermissionMultipleResult(results));
    } on PlatformException catch (e) {
      emit(PermissionError('Platform error requesting permissions: ${e.message}'));
    } on Object catch (e) {
      emit(PermissionError('Unexpected error requesting permissions: $e'));
    }
  }

  Future<void> _onSettings(
    PermissionSettingsOpened event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      final success = await _service.openAppSettings();
      if (!success) {
        emit(const PermissionError('Failed to open settings.'));
        return;
      }
      if (_currentPermission != null) {
        final status = await _service.checkPermission(_currentPermission!);
        emit(_mapStatusToState(_currentPermission!, status));
      }
    } on PlatformException catch (e) {
      emit(PermissionError('Platform error opening settings: ${e.message}'));
    } on Object catch (e) {
      emit(PermissionError('Unexpected error opening settings: $e'));
    }
  }


  PermissionState _mapStatusToState(
    AppPermission permission,
    PermissionStatus status,
  ) {
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      return PermissionGranted(permission);
    }
    if (status == PermissionStatus.permanentlyDenied) {
      return PermissionPermanentlyDenied(permission);
    }
    return PermissionDenied(permission);
  }
}
