import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_theme.dart';

/// The six Quick Actions on Home. Icon and color are fixed per action; the
/// label is localized, so it is looked up at build time.
enum QuickAction {
  fakeCall(Icons.call_rounded, Color(0xFFFF8FA3)),
  shareLocation(Icons.share_location_rounded, Color(0xFF3F5EFB)),
  recordEvidence(Icons.videocam_rounded, Color(0xFFFFA94D)),
  safeRoute(Icons.alt_route_rounded, Color(0xFF2FC28E)),
  checkInTimer(Icons.timer_outlined, AppTheme.accentPurple),
  dangerZone(Icons.local_fire_department_rounded, AppTheme.accentRed);

  const QuickAction(this.icon, this.color);

  final IconData icon;
  final Color color;

  String label(AppLocalizations l10n) => switch (this) {
        QuickAction.fakeCall => l10n.fakeCall,
        QuickAction.shareLocation => l10n.shareLocation,
        QuickAction.recordEvidence => l10n.recordEvidence,
        QuickAction.safeRoute => l10n.safeRoute,
        QuickAction.checkInTimer => l10n.checkInTimer,
        QuickAction.dangerZone => l10n.dangerZone,
      };
}
