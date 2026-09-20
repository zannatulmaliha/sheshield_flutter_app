import 'package:flutter/material.dart';
import '../models/trusted_contact.dart';
import '../state/game_scope.dart';
import '../theme/app_theme.dart';
import '../widgets/level_up_overlay.dart';
import '../widgets/staggered_fade_in.dart';
import '../widgets/xp_toast.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  static const _extraContacts = [
    TrustedContact(name: 'Rima Chowdhury', relation: 'Cousin', phone: '+880 177 445 2210', color: Color(0xFFFFA94D)),
    TrustedContact(name: 'Shafiq Islam', relation: 'Neighbor', phone: '+880 188 302 9981', color: Color(0xFF2FC28E)),
    TrustedContact(name: 'Farhana Akter', relation: 'Colleague', phone: '+880 199 774 5563', color: Color(0xFFB83280)),
  ];

  void _addContact() {
    final nextIndex = demoContacts.length - 4;
    if (nextIndex < 0 || nextIndex >= _extraContacts.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Demo contact list is full 💜')),
      );
      return;
    }

    setState(() => demoContacts.add(_extraContacts[nextIndex]));

    final game = GameScope.read(context);
    final leveledUp = game.addXp(15);
    final newBadge = demoContacts.length >= 5 && game.unlockBadge('circle_guardian');

    if (leveledUp) {
      showLevelUpCelebration(context, level: game.level, tierTitle: game.tierTitle);
    } else if (newBadge) {
      showXpToast(context, 15, label: 'Circle Guardian unlocked');
    } else {
      showXpToast(context, 15, label: 'Contact added');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            children: [
              StaggeredFadeIn(
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
            ],
          ),
          Positioned(
            right: 4,
            bottom: 140,
            child: FloatingActionButton.extended(
              onPressed: _addContact,
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
