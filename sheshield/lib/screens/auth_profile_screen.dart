import 'package:flutter/material.dart';
import '../services/auth_controller.dart';
import '../theme/app_theme.dart';

class AuthProfileScreen extends StatelessWidget {
  const AuthProfileScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    final user = controller.currentUser;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: [
          Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          _ProfileHeader(name: user?.name ?? 'SheShield User', email: user?.email ?? ''),
          const SizedBox(height: 22),
          const _EmergencyInfoCard(),
          const SizedBox(height: 26),
          const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 12),
          _SettingsList(onLogout: () => controller.logout()),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.name, required this.email});

  final String name;
  final String email;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
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
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.2),
              border: Border.all(color: Colors.white, width: 2.5),
            ),
            child: Center(
              child: Text(
                _initials,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
            child: const Icon(Icons.edit_rounded, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}

class _EmergencyInfoCard extends StatelessWidget {
  const _EmergencyInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.medical_information_rounded, color: AppColors.secondary, size: 20),
              SizedBox(width: 8),
              Text(
                'Emergency Info',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Row(
            children: [
              Expanded(child: _InfoTile(label: 'Blood Group', value: 'O+')),
              Expanded(child: _InfoTile(label: 'Allergies', value: 'None')),
            ],
          ),
          const SizedBox(height: 12),
          const _InfoTile(label: 'Home Address', value: 'Uttara, Dhaka, Bangladesh'),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(height: 3),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13.5, fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _SettingsList extends StatelessWidget {
  const _SettingsList({required this.onLogout});

  final VoidCallback onLogout;

  static const _items = [
    (Icons.lock_outline_rounded, 'Privacy & Permissions'),
    (Icons.notifications_none_rounded, 'Notification Settings'),
    (Icons.dark_mode_outlined, 'App Theme'),
    (Icons.help_outline_rounded, 'Help & Support'),
    (Icons.logout_rounded, 'Log Out'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: BorderRadius.circular(22),
        clipBehavior: Clip.antiAlias,
        child: Column(
        children: List.generate(_items.length, (i) {
          final (icon, label) = _items[i];
          final isLast = i == _items.length - 1;
          final isLogout = label == 'Log Out';
          return Column(
            children: [
              ListTile(
                onTap: isLogout ? onLogout : () {},
                leading: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: (isLogout ? AppColors.sosEnd : AppColors.primary).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 18, color: isLogout ? AppColors.sosEnd : AppColors.primary),
                ),
                title: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                    color: isLogout ? AppColors.sosEnd : AppColors.textPrimary,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
              ),
              if (!isLast) const Divider(height: 1, indent: 68, endIndent: 16, color: Color(0xFFF0EEF7)),
            ],
          );
        }),
        ),
      ),
    );
  }
}
