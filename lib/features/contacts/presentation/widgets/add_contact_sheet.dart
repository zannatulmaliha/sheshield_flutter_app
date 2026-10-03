import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/contacts/presentation/widgets/add_contact_form.dart';

Future<void> showAddContactSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AddContactSheet(),
  );
}

/// Keyboard-aware rounded container around [AddContactForm].
class AddContactSheet extends StatelessWidget {
  const AddContactSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: softShadow(opacity: 0.18),
          ),
          child: const AddContactForm(),
        ),
      ),
    );
  }
}
