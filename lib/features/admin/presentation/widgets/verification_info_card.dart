import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';

class VerificationInfoCard extends StatelessWidget {
  const VerificationInfoCard({super.key, required this.verification});

  final AdminVerification verification;

  @override
  Widget build(BuildContext context) {
    final submittedAt =
        DateFormat.yMMMd().add_jm().format(verification.createdAt.toLocal());

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              verification.displayName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text('Email: ${verification.userEmail}'),
            Text('Phone: ${verification.userPhone}'),
            Text('Account type: ${verification.userType}'),
            Text('Status: ${verification.status.toUpperCase()}'),
            Text('Submitted: $submittedAt'),
          ],
        ),
      ),
    );
  }
}
