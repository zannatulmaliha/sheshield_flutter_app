import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';

enum AppMode { user, helper }

/// Lets a dual-role (user_helper) account switch between asking for
/// help and responding to alerts. A pill segmented control, not a
/// bottom-nav tab, so it reads as "which hat am I wearing" rather than
/// a page within one flow. Purely presentational -- the caller (the
/// root shell) owns which mode is selected.
class ModeSwitch extends StatelessWidget {
  const ModeSwitch({super.key, required this.mode, required this.onChanged});

  final AppMode mode;
  final ValueChanged<AppMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 8, 20, 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.accentEmerald.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _segment(AppMode.user, 'Ask for help', Icons.sos_rounded)),
          Expanded(child: _segment(AppMode.helper, 'Respond to alerts', Icons.volunteer_activism_rounded)),
        ],
      ),
    );
  }

  Widget _segment(AppMode value, String label, IconData icon) {
    final selected = mode == value;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(13),
          boxShadow: selected
              ? [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, 3))]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? AppTheme.accentEmerald : Colors.black54),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12,
                color: selected ? AppTheme.accentEmerald : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
