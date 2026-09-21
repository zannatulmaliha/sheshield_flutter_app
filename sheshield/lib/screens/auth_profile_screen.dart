import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../models/user_type.dart';
import '../services/auth_controller.dart';
import '../theme/app_theme.dart';
import 'helper_verification_screen.dart';
import 'profile_edit_sheets.dart';

/// Your real account: name, phone and address are editable and saved to the
/// server. (The original ProfileScreen shows a hard-coded blood group and
/// address; this one shows only real data. Kept as a separate file so
/// profile_screen.dart isn't modified.)
class AuthProfileScreen extends StatelessWidget {
  const AuthProfileScreen({super.key, required this.controller});

  final AuthController controller;

  void _snack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _edit(BuildContext context, Future<bool> Function(BuildContext, AuthController) sheet) async {
    final saved = await sheet(context, controller);
    if (saved && context.mounted) _snack(context, 'Profile updated');
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text("You'll need to sign in again to send an SOS."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Log out', style: TextStyle(color: AppColors.sosEnd)),
          ),
        ],
      ),
    );
    if (ok == true) await controller.logout();
  }

  void _openVerification(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => HelperVerificationScreen(controller: controller)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final user = controller.currentUser;
        if (user == null) return const SizedBox.shrink();

        return SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
            children: [
              Text('Profile', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              _ProfileHeader(user: user, onEdit: () => _edit(context, showEditNameSheet)),
              const SizedBox(height: 22),
              _RoleCard(user: user, onVerify: () => _openVerification(context)),
              const SizedBox(height: 26),
              const _SectionLabel('Account details'),
              const SizedBox(height: 12),
              _Card(
                children: [
                  _DetailRow(
                    icon: Icons.person_outline_rounded,
                    label: 'Name',
                    value: user.name,
                    onTap: () => _edit(context, showEditNameSheet),
                  ),
                  _DetailRow(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: user.countryCode.isEmpty ? user.phone : '${user.countryCode} ${user.phone}',
                    onTap: () => _edit(context, showEditPhoneSheet),
                  ),
                  _DetailRow(
                    icon: Icons.home_outlined,
                    label: 'Home address',
                    value: user.address.isEmpty ? 'Add your home address' : user.address,
                    muted: user.address.isEmpty,
                    onTap: () => _edit(context, showEditAddressSheet),
                  ),
                  _DetailRow(
                    icon: Icons.mail_outline_rounded,
                    label: 'Email',
                    value: user.email,
                    locked: true,
                    onTap: () => _snack(context, "Email can't be changed yet."),
                  ),
                ],
              ),
              const SizedBox(height: 26),
              const _SectionLabel('Settings'),
              const SizedBox(height: 12),
              _Card(
                children: [
                  for (final (icon, label) in _placeholderSettings)
                    _DetailRow(
                      icon: icon,
                      label: label,
                      onTap: () => _snack(context, '$label is coming soon.'),
                    ),
                  _DetailRow(
                    icon: Icons.logout_rounded,
                    label: 'Log Out',
                    danger: true,
                    onTap: () => _confirmLogout(context),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  static const _placeholderSettings = [
    (Icons.lock_outline_rounded, 'Privacy & Permissions'),
    (Icons.notifications_none_rounded, 'Notification Settings'),
    (Icons.help_outline_rounded, 'Help & Support'),
  ];
}

const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

String _memberSince(DateTime d) {
  final local = d.toLocal();
  return 'Member since ${_months[local.month - 1]} ${local.year}';
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user, required this.onEdit});

  final AppUser user;
  final VoidCallback onEdit;

  String get _initials {
    final parts = user.name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
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
                  user.name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  _memberSince(user.createdAt),
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onEdit,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: const Icon(Icons.edit_rounded, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

/// What the account is, and for helpers, whether the server has verified it.
/// The verified flag only ever comes from the server; the app cannot set it.
class _RoleCard extends StatelessWidget {
  const _RoleCard({required this.user, required this.onVerify});

  final AppUser user;
  final VoidCallback onVerify;

  String get _roleLabel => switch (user.userType) {
        UserType.user => 'User',
        UserType.helper => 'Helper',
        UserType.userHelper => 'User & Helper',
      };

  bool get _isHelper => user.userType != UserType.user;

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
            children: [
              const Icon(Icons.badge_outlined, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Your role',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: AppColors.textPrimary),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.chipBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _roleLabel,
                  style: const TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.w700, fontSize: 12),
                ),
              ),
            ],
          ),
          if (_isHelper) ...[
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  user.isHelperVerified ? Icons.verified_rounded : Icons.hourglass_empty_rounded,
                  size: 18,
                  color: user.isHelperVerified ? AppColors.success : AppColors.warning,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    user.isHelperVerified
                        ? 'Verified helper. You can respond to alerts.'
                        : 'Not verified yet. Helpers must be verified before they can respond to alerts.',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            if (!user.isHelperVerified) ...[
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: onVerify,
                  child: const Text('Get verified', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.textPrimary),
      );
}

class _Card extends StatelessWidget {
  const _Card({required this.children});
  final List<Widget> children;

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
          children: [
            for (var i = 0; i < children.length; i++) ...[
              children[i],
              if (i != children.length - 1)
                const Divider(height: 1, indent: 68, endIndent: 16, color: Color(0xFFF0EEF7)),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.muted = false,
    this.locked = false,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;
  final bool muted;
  final bool locked;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final accent = danger ? AppColors.sosEnd : AppColors.primary;
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(color: accent.withValues(alpha: 0.1), shape: BoxShape.circle),
        child: Icon(icon, size: 18, color: accent),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: value == null ? 13.5 : 11.5,
          color: danger
              ? AppColors.sosEnd
              : (value == null ? AppColors.textPrimary : AppColors.textSecondary),
        ),
      ),
      subtitle: value == null
          ? null
          : Text(
              value!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13.5,
                color: muted ? AppColors.textSecondary : AppColors.textPrimary,
              ),
            ),
      trailing: Icon(
        locked ? Icons.lock_outline_rounded : (danger ? null : Icons.chevron_right_rounded),
        size: locked ? 18 : 24,
        color: AppColors.textSecondary,
      ),
    );
  }
}
