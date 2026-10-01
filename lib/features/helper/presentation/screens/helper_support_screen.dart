import 'package:flutter/material.dart';
import 'package:sheshield/features/helper/presentation/helper_colors.dart';
import 'package:url_launcher/url_launcher.dart';

/// Help & Support tab. Text colours are explicit on the white cards: in
/// dark mode the inherited (light) colour made the card titles invisible.
class HelperSupportScreen extends StatelessWidget {
  const HelperSupportScreen({super.key});

  static const _supportEmail = 'helper-support@sheshield.com';

  Future<void> _open(BuildContext context, Uri uri) async {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Couldn't open that.")));
    }
  }

  void _info(BuildContext context, String title, String body) => showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(title: Text(title), content: SingleChildScrollView(child: Text(body)), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Close'))]),
      );

  Future<void> _quickReport(BuildContext context, String category) {
    final uri = Uri(scheme: 'mailto', path: _supportEmail, queryParameters: {'subject': 'Helper report: $category'});
    return _open(context, uri);
  }

  @override
  Widget build(BuildContext context) {
    Widget tile(IconData icon, Color color, String title, String sub, VoidCallback onTap) => Card(
          color: context.hp.surface,
          margin: EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(backgroundColor: color.withValues(alpha: 0.12), child: Icon(icon, color: color)),
            title: Text(title, style: TextStyle(color: context.hp.textPrimary, fontWeight: FontWeight.w800)),
            subtitle: Text(sub, style: TextStyle(color: context.hp.textSecondary)),
            trailing: Icon(Icons.chevron_right_rounded, color: context.hp.textSecondary),
            onTap: onTap,
          ),
        );

    Widget section(String t) => Padding(padding: EdgeInsets.fromLTRB(4, 16, 0, 8), child: Text(t, style: TextStyle(color: context.hp.textSecondary, fontWeight: FontWeight.w700)));

    return ListView(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 110),
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Color(0xFFDC2626).withValues(alpha: 0.12), borderRadius: BorderRadius.circular(16), border: Border.all(color: Color(0xFFDC2626).withValues(alpha: 0.4))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Emergency Hotline', style: TextStyle(color: context.hp.textPrimary, fontWeight: FontWeight.w800, fontSize: 17)),
            SizedBox(height: 4),
            Text('Available 24/7 for urgent situations during active responses', style: TextStyle(color: context.hp.textSecondary, fontSize: 12.5)),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _open(context, Uri(scheme: 'tel', path: '999')),
                icon: Icon(Icons.call_rounded),
                label: Text('Call 999'),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFDC2626), foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 14)),
              ),
            ),
          ]),
        ),
        section('Quick Access'),
        tile(Icons.shield_rounded, context.hp.primary, 'Safety Protocols', 'Essential guidelines for helpers', () => _info(context, 'Safety protocols',
            '1. Never go alone into an unsafe place; meet in public, well-lit areas.\n2. Tell someone you trust where you are going.\n3. Keep the in-app chat open; do not share your real number.\n4. If you feel unsafe at any point, back out - there is no penalty.\n5. Call 999 for anything life-threatening.\n6. Do not confront an aggressor. Your job is to get the person to safety.')),
        tile(Icons.report_rounded, Color(0xFF2563EB), 'Report an issue', 'During or after a response', () => _quickReport(context, 'Issue')),
        tile(Icons.description_rounded, Color(0xFF16A34A), 'Helper Guidelines', 'Complete helper handbook', () => _info(context, 'Helper guidelines',
            'Helpers are volunteers connecting nearby people to help. You are not expected to put yourself at risk. Accept only alerts you can reach safely, update your status (En route, Arrived, Assisting), and mark the alert resolved only once the person is safe. Never ask for personal details; the app keeps both sides pseudonymous.')),
        tile(Icons.help_rounded, Color(0xFFEA580C), 'FAQs', 'Common questions answered', () => _info(context, 'FAQs',
            'Why can I not see the person\'s name before accepting?\nTo protect their privacy - you only see the area and type of emergency.\n\nWhat if two helpers accept?\nThe first to accept is matched; others are told it is already matched.\n\nCan I back out?\nYes, at any time, with no penalty. The alert returns to other helpers.\n\nWhat do the alert reasons mean?\n"Possible fall detected", "Sudden sprint detected" etc. come from the person\'s phone sensors and were confirmed or unanswered; treat each as a real emergency.')),
        section('Quick Report'),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(color: context.hp.surface, borderRadius: BorderRadius.circular(16)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Choose a category to quickly report an issue:', style: TextStyle(color: context.hp.textSecondary)),
            SizedBox(height: 10),
            Wrap(spacing: 10, runSpacing: 10, children: [
              for (final (icon, label) in const [(Icons.warning_amber_rounded, 'Safety Concern'), (Icons.shield_rounded, 'False Alert'), (Icons.chat_rounded, 'User Behavior'), (Icons.help_outline_rounded, 'Other Issue')])
                SizedBox(
                  width: 150,
                  child: OutlinedButton.icon(
                    onPressed: () => _quickReport(context, label),
                    icon: Icon(icon, size: 18),
                    label: Text(label),
                    style: OutlinedButton.styleFrom(foregroundColor: context.hp.textPrimary, padding: EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
            ]),
          ]),
        ),
        section('Contact Support'),
        tile(Icons.email_rounded, context.hp.primary, 'Email Support', _supportEmail, () => _open(context, Uri(scheme: 'mailto', path: _supportEmail))),
        tile(Icons.chat_rounded, context.hp.primary, 'Live Chat', 'Available 9 AM - 9 PM', () => _info(context, 'Live chat', 'Live chat is staffed 9 AM - 9 PM. Outside those hours, email $_supportEmail and call 999 for emergencies.')),
        section('Legal & Privacy'),
        tile(Icons.gavel_rounded, Colors.blueGrey, 'Helper Terms of Service', 'How the helper program works', () => _open(context, Uri.parse('https://sheshield.com/helper-terms'))),
        tile(Icons.privacy_tip_rounded, Colors.blueGrey, 'Privacy Policy', 'How your data is handled', () => _open(context, Uri.parse('https://sheshield.com/privacy'))),
      ],
    );
  }
}