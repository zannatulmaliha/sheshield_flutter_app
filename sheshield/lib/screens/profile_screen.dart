import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/badge_grid.dart';
import '../widgets/helper_dashboard.dart';
import '../widgets/segmented_toggle.dart';
import '../widgets/staggered_fade_in.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
        children: [
          Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          SegmentedToggle(
            labels: const ['My Profile', 'Helper Dashboard'],
            selectedIndex: _tab,
            onChanged: (i) => setState(() => _tab = i),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero).animate(animation),
                child: child,
              ),
            ),
            child: _tab == 0
                ? const _MyProfileContent(key: ValueKey('my_profile'))
                : const HelperDashboard(key: ValueKey('helper_dashboard')),
          ),
        ],
      ),
    );
  }
}

class _MyProfileContent extends StatelessWidget {
  const _MyProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredFadeIn(
      children: [
        const _ProfileHeader(),
        const SizedBox(height: 22),
        const _EmergencyInfoCard(),
        const SizedBox(height: 26),
        const Text(
          'Achievements',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        const BadgeGrid(),
        const SizedBox(height: 26),
        const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        _SettingsList(),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

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
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (context, value, child) => Transform.scale(scale: value, child: child),
            child: Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
                border: Border.all(color: Colors.white, width: 2.5),
              ),
              child: const Center(
                child: Text(
                  'ZM',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 22),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Zannatul Maliha',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                ),
                const SizedBox(height: 4),
                Text(
                  'zannatulmaliha@iut-dhaka.edu',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
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
                onTap: () {},
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
