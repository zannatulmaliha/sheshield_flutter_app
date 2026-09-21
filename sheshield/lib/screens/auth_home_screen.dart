import 'package:flutter/material.dart';
import '../models/saved_contact.dart';
import '../services/auth_controller.dart';
import '../services/contacts_store.dart';
import '../theme/app_theme.dart';
import '../widgets/auth_sos_button.dart';
import '../widgets/section_title.dart';

/// Same layout as HomeScreen, but with real data: your name, your actual
/// trusted contacts, and an SOS button that really sends. (The original
/// shows "Hi, Zannat" and demo contacts. This one is kept separate so
/// home_screen.dart isn't modified.)
class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({
    super.key,
    required this.controller,
    required this.store,
    required this.onOpenContacts,
  });

  final AuthController controller;
  final ContactsStore store;
  final VoidCallback onOpenContacts;

  String get _fullName => controller.currentUser?.name.trim() ?? '';

  String get _firstName {
    if (_fullName.isEmpty) return 'there';
    return _fullName.split(RegExp(r'\s+')).first;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            children: [
              _TopBar(name: _firstName),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    AuthSosButton(
                      userName: _fullName.isEmpty ? 'Someone' : _fullName,
                      store: store,
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Tap for Emergency Alert',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _StatusCard(loading: store.loading, contactCount: store.contacts.length),
              const SizedBox(height: 28),
              const SectionTitle(title: 'Quick Actions'),
              const SizedBox(height: 14),
              const _QuickActionsGrid(),
              const SizedBox(height: 28),
              SectionTitle(
                title: 'Trusted Contacts',
                actionLabel: 'See all',
                onAction: onOpenContacts,
              ),
              const SizedBox(height: 14),
              _ContactsPreview(
                contacts: store.contacts,
                loading: store.loading,
                onTap: onOpenContacts,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: AppColors.heroGradient),
            boxShadow: softShadow(color: AppColors.primary, opacity: 0.25),
          ),
          child: const Icon(Icons.shield_rounded, color: Colors.white, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $name 👋',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Text(
                'Stay safe, stay confident',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        _IconBadge(icon: Icons.notifications_none_rounded, onTap: () {}),
      ],
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: softShadow(opacity: 0.10),
        ),
        child: Stack(
          children: [
            Center(child: Icon(icon, color: AppColors.textPrimary, size: 22)),
            Positioned(
              top: 11,
              right: 11,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.loading, required this.contactCount});

  final bool loading;
  final int contactCount;

  @override
  Widget build(BuildContext context) {
    final ready = !loading && contactCount > 0;
    final title = loading ? 'Getting ready…' : (ready ? 'SOS is ready' : 'Almost ready');
    final subtitle = loading
        ? 'Loading your trusted contacts.'
        : (ready
            ? '$contactCount trusted contact${contactCount == 1 ? '' : 's'} will be alerted when you send an SOS.'
            : 'Add at least one trusted contact so an SOS alert has someone to reach.');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.heroGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: softShadow(color: AppColors.primary, opacity: 0.28),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      ready ? Icons.verified_rounded : Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 12.5, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.location_on_rounded, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  static const _actions = [
    (Icons.call_rounded, 'Fake Call', Color(0xFFFF8FA3)),
    (Icons.share_location_rounded, 'Share Location', Color(0xFF3F5EFB)),
    (Icons.videocam_rounded, 'Record Evidence', Color(0xFFFFA94D)),
    (Icons.alt_route_rounded, 'Safe Route', Color(0xFF2FC28E)),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 14,
      childAspectRatio: 2.5,
      children: _actions.map((a) {
        final (icon, label, color) = a;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: softShadow(opacity: 0.08),
          ),
          child: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.14), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 19),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ContactsPreview extends StatelessWidget {
  const _ContactsPreview({required this.contacts, required this.loading, required this.onTap});

  final List<SavedContact> contacts;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = loading
        ? 'Loading contacts…'
        : contacts.isEmpty
            ? 'No contacts yet. Tap to add one'
            : '${contacts.length} contact${contacts.length == 1 ? '' : 's'} will be alerted';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: softShadow(opacity: 0.08),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 84,
              height: 40,
              child: contacts.isEmpty
                  ? const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.group_add_rounded, color: AppColors.textSecondary),
                    )
                  : Stack(
                      children: List.generate(contacts.length.clamp(0, 3), (i) {
                        final c = contacts[i];
                        return Positioned(
                          left: i * 24.0,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: c.color,
                              child: Text(
                                c.initials,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
            ),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, color: AppColors.textPrimary),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
