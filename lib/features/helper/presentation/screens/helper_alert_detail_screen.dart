import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';

/// Shown only after AcceptAlertUseCase succeeds -- the one screen in
/// helper mode that ever displays an exact location or phone number,
/// and only to the single helper who won the accept race.
class HelperAlertDetailScreen extends StatelessWidget {
  const HelperAlertDetailScreen({super.key, required this.alert});
  final AcceptedAlert alert;

  Future<void> _openMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${alert.latitude},${alert.longitude}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _call(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: alert.fullPhone.replaceAll(' ', ''));
    final opened = await launchUrl(uri);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Couldn't open the dialer.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Respond now')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.accentRed.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.emergency_share_rounded, color: AppTheme.accentRed),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${alert.userName} needs help. You accepted this alert -- get there safely.',
                        style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.black87, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Contact', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.black54)),
              const SizedBox(height: 6),
              Text(alert.fullPhone, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Colors.black87)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _openMaps,
                      icon: const Icon(Icons.directions_rounded),
                      label: const Text('Open route'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentEmerald,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _call(context),
                      icon: const Icon(Icons.call_rounded),
                      label: const Text('Call'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.accentEmerald,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
