import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';

const _faq = <(String, String)>[
  (
    'How does the SOS button work?',
    "Pressing SOS sends your live location to every trusted contact by SMS, and starts a live-tracking link they "
        "can open with no login. Contacts who've linked their own SheShield account also get an instant alarm push.",
  ),
  (
    "What does the Check-In Timer do?",
    "Set a timer before doing something risky. If you don't check in ('I'm Safe') before it reaches zero, an SOS "
        "is sent automatically -- the same alert the SOS button sends.",
  ),
  (
    'Why does the app need location and SMS permissions?',
    'Location is needed to send your live position with an SOS. SMS lets the app text your trusted contacts '
        "directly from your own number, which works even if the app's server can't be reached.",
  ),
  (
    'Will my trusted contacts know when I press SOS?',
    "Yes -- every trusted contact gets a text with your location the moment you press SOS. There's no silent or "
        "delayed mode.",
  ),
];

const _supportEmail = 'support@sheshield.app';

/// Emergency helpline numbers a person in Bangladesh (this app's primary
/// market -- see the Bangla localization) may need right now, not just
/// SheShield's own support inbox. Deliberately separate from the SOS
/// button: these are for calling someone directly, no app flow involved.
const _emergencyNumbers = <(String, String)>[
  ('999', 'National Emergency Service (police, fire, ambulance)'),
  ('109', 'National Helpline for Violence Against Women and Children'),
];

class HelpSupportScreen extends ConsumerWidget {
  const HelpSupportScreen({super.key});

  Future<void> _emailSupport() => launchUrl(
        Uri(scheme: 'mailto', path: _supportEmail, query: 'subject=SheShield support'),
      );

  Future<void> _call(String number) => launchUrl(Uri.parse('tel:$number'));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.helpSupport),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text('Emergency numbers', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: colors.textPrimary)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: softShadow(opacity: 0.07),
            ),
            child: Column(
              children: List.generate(_emergencyNumbers.length, (i) {
                final (number, label) = _emergencyNumbers[i];
                final isLast = i == _emergencyNumbers.length - 1;
                return Column(
                  children: [
                    ListTile(
                      onTap: () => _call(number),
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(color: colors.sosStart.withValues(alpha: 0.12), shape: BoxShape.circle),
                        child: Icon(Icons.call_rounded, color: colors.sosStart, size: 19),
                      ),
                      title: Text(number, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: colors.textPrimary)),
                      subtitle: Text(label, style: TextStyle(fontSize: 11.5, color: colors.textSecondary)),
                    ),
                    if (!isLast) Divider(height: 1, indent: 68, endIndent: 16, color: colors.chipBackground),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 24),
          Text('Frequently asked questions', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: colors.textPrimary)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: softShadow(opacity: 0.07),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: Column(
                children: [
                  for (final (question, answer) in _faq)
                    ExpansionTile(
                      title: Text(question, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: colors.textPrimary)),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Text(answer, style: TextStyle(fontSize: 12.5, color: colors.textSecondary, height: 1.4)),
                      ],
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: colors.chipBackground),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _emailSupport,
              icon: Icon(Icons.email_outlined, color: colors.primary),
              label: Text('Email support', style: TextStyle(fontWeight: FontWeight.w800, color: colors.primary)),
            ),
          ),
        ],
      ),
    );
  }
}
