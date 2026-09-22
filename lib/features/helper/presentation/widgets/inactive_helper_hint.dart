import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';

class InactiveHelperHint extends StatelessWidget {
  const InactiveHelperHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.accentEmerald.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline_rounded, color: AppTheme.accentEmerald),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Turn on the switch above to see SOS alerts near you and respond to them.',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 12.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
