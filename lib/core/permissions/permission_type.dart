import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

enum AppPermission {
  camera,
  microphone,
  photos,
  storage,
  location,
  locationAlways,
  notification,
  contacts,
  bluetooth,
  bluetoothScan,
  phone,
  sensors,
  speechRecognition,
}

extension AppPermissionX on AppPermission {
  Permission get handler => switch (this) {
        AppPermission.camera => Permission.camera,
        AppPermission.microphone => Permission.microphone,
        AppPermission.photos => _photosPermission,
        AppPermission.storage => Permission.storage,
        AppPermission.location => Permission.locationWhenInUse,
        AppPermission.locationAlways => Permission.locationAlways,
        AppPermission.notification => Permission.notification,
        AppPermission.contacts => Permission.contacts,
        AppPermission.bluetooth => Permission.bluetooth,
        AppPermission.bluetoothScan => Permission.bluetoothScan,
        AppPermission.phone => Permission.phone,
        AppPermission.sensors => Permission.sensors,
        AppPermission.speechRecognition => Permission.speech,
      };

  Permission get _photosPermission {
    if (Platform.isAndroid) {
      try {
        final match = RegExp(r'SDK\s+(\d+)').firstMatch(Platform.operatingSystemVersion);
        if (match != null && int.parse(match.group(1)!) < 33) {
          return Permission.storage;
        }
      } on Object catch (_) {}
    }
    return Permission.photos;
  }
}
