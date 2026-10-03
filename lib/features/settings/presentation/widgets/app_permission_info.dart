import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// One runtime permission the app asks for, and why.
class AppPermissionInfo {
  const AppPermissionInfo({
    required this.permission,
    required this.icon,
    required this.title,
    required this.reason,
  });

  final Permission permission;
  final IconData icon;
  final String title;
  final String reason;
}

/// Ordered by how central each is to the app's purpose, so a denial can be
/// understood (and fixed via the OS settings link) instead of silently
/// breaking a feature.
const appPermissions = <AppPermissionInfo>[
  AppPermissionInfo(
    permission: Permission.locationWhenInUse,
    icon: Icons.location_on_rounded,
    title: 'Location',
    reason: 'Needed to send your live location with an SOS alert and to show '
        'nearby helpers where you are.',
  ),
  AppPermissionInfo(
    permission: Permission.sms,
    icon: Icons.sms_rounded,
    title: 'SMS',
    reason: 'Lets the app text your trusted contacts directly from your own '
        'phone number when you press SOS.',
  ),
  AppPermissionInfo(
    permission: Permission.camera,
    icon: Icons.videocam_rounded,
    title: 'Camera & microphone',
    reason: 'Needed to record evidence video from the Quick Actions panel.',
  ),
  AppPermissionInfo(
    permission: Permission.notification,
    icon: Icons.notifications_active_rounded,
    title: 'Notifications',
    reason: 'Needed to alarm your phone the instant a trusted contact sends an SOS.',
  ),
];
