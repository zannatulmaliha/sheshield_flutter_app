import 'package:flutter/material.dart';
import '../models/trusted_contact.dart';
import '../theme/app_theme.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            children: [
              Text('Trusted Contacts', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 4),
              const Text(
                'These people will be notified when you send an SOS alert.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.chipBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Add at least 3 contacts for reliable emergency coverage.',
                        style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w600, fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...demoContacts.map((c) => _ContactTile(contact: c)),
            ],
          ),
          Positioned(
            right: 4,
            bottom: 140,
            child: FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add contact flow coming soon')),
                );
              },
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text('Add Contact', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({required this.contact});
  final TrustedContact contact;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: contact.color,
            child: Text(
              contact.initials,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        contact.name,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textPrimary),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (contact.isPrimary) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Primary',
                          style: TextStyle(color: AppColors.success, fontSize: 10, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${contact.relation} · ${contact.phone}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          _CircleIconButton(icon: Icons.call_rounded, color: AppColors.success),
          const SizedBox(width: 8),
          _CircleIconButton(icon: Icons.message_rounded, color: AppColors.primary),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 18),
    );
  }
}
