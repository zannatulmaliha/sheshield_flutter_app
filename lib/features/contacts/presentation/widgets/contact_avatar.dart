import 'package:flutter/material.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';

/// Initials in a circle. The backend stores no color for a contact, so a
/// stable one is derived from the contact's id.
class ContactAvatar extends StatelessWidget {
  const ContactAvatar({super.key, required this.contact, required this.palette});

  final TrustedContact contact;
  final AppPalette palette;

  Color get _backgroundColor {
    final choices = [
      palette.primary,
      palette.secondary,
      palette.success,
      palette.warning,
      palette.primaryDark,
    ];
    return choices[contact.id.hashCode.abs() % choices.length];
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: _backgroundColor,
      child: Text(
        contact.initials,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 15,
        ),
      ),
    );
  }
}
