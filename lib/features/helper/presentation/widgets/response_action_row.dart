import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/chat/presentation/sos_chat_screen.dart';
import 'package:url_launcher/url_launcher.dart';

/// Navigate / Call 999 / Chat.
class ResponseActionRow extends StatelessWidget {
  const ResponseActionRow({
    super.key,
    required this.alertId,
    required this.point,
    required this.palette,
  });

  final String alertId;
  final LatLng point;
  final AppPalette palette;

  Future<void> _openNavigation() => launchUrl(
        Uri.parse(
          'https://www.google.com/maps/dir/?api=1'
          '&destination=${point.latitude},${point.longitude}',
        ),
        mode: LaunchMode.externalApplication,
      );

  Future<void> _callEmergencyNumber(BuildContext context) async {
    final didOpen = await launchUrl(Uri(scheme: 'tel', path: '999'));
    if (!didOpen && context.mounted) context.showMessage("Couldn't open the dialer.");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.navigation_rounded,
            label: 'Navigate',
            color: const Color(0xFF2563EB),
            onTap: _openNavigation,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.call_rounded,
            label: 'Call 999',
            color: const Color(0xFF16A34A),
            onTap: () => _callEmergencyNumber(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _ActionButton(
            icon: Icons.chat_bubble_rounded,
            label: 'Chat',
            color: palette.primary,
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => SosChatScreen(sosId: alertId, iAmHelper: true),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
