import 'package:permission_handler/permission_handler.dart';

extension PermissionStatusX on PermissionStatus {
  bool get isGrantedOrLimited => isGranted || isLimited;

  bool get isDeniedPermanently => isPermanentlyDenied;

  bool get needsRequest => isDenied || isRestricted;

  String get userMessage => switch (this) {
        PermissionStatus.granted => 'Permission granted.',
        PermissionStatus.denied => 'Permission denied.',
        PermissionStatus.restricted => 'Permission restricted by system.',
        PermissionStatus.limited => 'Permission limited.',
        PermissionStatus.permanentlyDenied =>
          'Permission permanently denied. Please enable in settings.',
        PermissionStatus.provisional => 'Permission limited (provisional).',
      };
}
