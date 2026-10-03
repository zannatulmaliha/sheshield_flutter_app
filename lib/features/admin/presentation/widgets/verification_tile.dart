import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';

class VerificationTile extends StatelessWidget {
  const VerificationTile({super.key, required this.verification, required this.onTap});

  final AdminVerification verification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final submittedAt =
        DateFormat.yMMMd().add_jm().format(verification.createdAt.toLocal());

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          child: Icon(
            verification.isPending
                ? Icons.hourglass_top_rounded
                : Icons.verified_user_rounded,
          ),
        ),
        title: Text(
          verification.displayName,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${verification.userEmail}\n${verification.userPhone}\n'
            'Submitted $submittedAt',
          ),
        ),
        trailing: Chip(label: Text(verification.status.toUpperCase())),
        onTap: onTap,
      ),
    );
  }
}
