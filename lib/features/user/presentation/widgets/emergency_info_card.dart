import 'package:flutter/material.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/shared/entities/app_user.dart';
import 'package:sheshield/shared/entities/user_type.dart';

/// Phone, role and home address: what a responder needs in an emergency.
class EmergencyInfoCard extends StatelessWidget {
  const EmergencyInfoCard({
    super.key,
    required this.palette,
    required this.user,
    required this.onEditAddress,
  });

  final AppPalette palette;
  final AppUser user;
  final VoidCallback onEditAddress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final address = user.address?.trim() ?? '';
    final roleLabel = switch (user.userType) {
      UserType.user => l10n.userTypeUser,
      UserType.helper => l10n.userTypeHelper,
      UserType.userHelper => l10n.userTypeUserHelper,
    };

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: softShadow(opacity: 0.07),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.medical_information_rounded, color: palette.secondary, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n.emergencyInfo,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                  color: palette.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  palette: palette,
                  label: l10n.phone,
                  value: '${user.countryCode} ${user.phone}',
                ),
              ),
              Expanded(child: _InfoTile(palette: palette, label: l10n.role, value: roleLabel)),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onEditAddress,
            child: _InfoTile(
              palette: palette,
              label: l10n.homeAddress,
              value: address.isEmpty ? l10n.tapToAdd : address,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.palette, required this.label, required this.value});

  final AppPalette palette;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: palette.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            color: palette.textPrimary,
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
