import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';

@immutable
class PermissionStatuses {
  const PermissionStatuses({required this.statuses, required this.refresh});

  final Map<Permission, PermissionStatus> statuses;

  /// Re-reads every status; runs on its own at start and whenever the app
  /// resumes.
  final Future<void> Function() refresh;

  PermissionStatus? operator [](Permission permission) => statuses[permission];
}

/// Tracks the current status of [permissions]. Coming back from the OS
/// settings screen resumes the app, so a just-granted permission shows up
/// without the person leaving and re-entering the screen.
PermissionStatuses usePermissionStatuses(List<Permission> permissions) {
  final statuses = useState(const <Permission, PermissionStatus>{});
  final isMounted = useIsMounted();

  Future<void> refresh() async {
    final latest = <Permission, PermissionStatus>{
      for (final permission in permissions) permission: await permission.status,
    };
    if (isMounted()) statuses.value = latest;
  }

  useEffect(() {
    refresh();
    return null;
  }, const [],);

  useOnAppLifecycleStateChange((_, state) {
    if (state == AppLifecycleState.resumed) refresh();
  });

  return PermissionStatuses(statuses: statuses.value, refresh: refresh);
}
