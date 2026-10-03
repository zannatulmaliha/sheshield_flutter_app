import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/permission_extensions.dart';
import 'package:sheshield/features/settings/presentation/widgets/app_permission_info.dart';

class PermissionTile extends StatelessWidget {
  const PermissionTile({
    super.key,
    required this.info,
    required this.status,
    required this.palette,
    required this.onTap,
  });

  final AppPermissionInfo info;
  final PermissionStatus? status;
  final AppPalette palette;
  final VoidCallback onTap;

  String get _statusLabel => switch (status) {
        PermissionStatus.granted || PermissionStatus.limited => 'Allowed',
        PermissionStatus.permanentlyDenied => 'Denied — tap to open settings',
        _ => 'Not allowed — tap to allow',
      };

  @override
  Widget build(BuildContext context) {
    final isAllowed = status.isAllowed;
    final accent = isAllowed ? palette.success : palette.warning;

    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(info.icon, size: 19, color: accent),
      ),
      title: Text(
        info.title,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13.5,
          color: palette.textPrimary,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          info.reason,
          style: TextStyle(fontSize: 11.5, color: palette.textSecondary, height: 1.3),
        ),
      ),
      trailing: Text(
        _statusLabel,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isAllowed ? palette.success : palette.textSecondary,
        ),
      ),
    );
  }
}
