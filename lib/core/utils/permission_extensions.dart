import 'package:permission_handler/permission_handler.dart';

extension PermissionStatusX on PermissionStatus? {
  /// Granted in full, or iOS "limited" access (still usable).
  bool get isAllowed =>
      this == PermissionStatus.granted || this == PermissionStatus.limited;
}
