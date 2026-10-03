import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/admin/domain/entities/audit_entry.dart';
import 'package:sheshield/features/admin/presentation/widgets/admin_section_card.dart';

class AuditTrailCard extends StatelessWidget {
  const AuditTrailCard({super.key, required this.palette, required this.entries});

  final AppPalette palette;
  final List<AuditEntry> entries;

  @override
  Widget build(BuildContext context) {
    return AdminSectionCard(
      palette: palette,
      title: 'Audit trail (reported account)',
      children: [
        if (entries.isEmpty)
          Text('No audit entries.', style: TextStyle(color: palette.textSecondary))
        else
          for (final entry in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '${DateFormat.yMMMd().add_jm().format(entry.createdAt.toLocal())}'
                ' — ${entry.action} (by ${entry.actorId})',
                style: TextStyle(fontSize: 13, color: palette.textPrimary),
              ),
            ),
      ],
    );
  }
}
