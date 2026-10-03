import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// The three photos a verification needs, with how each one is captured.
enum VerificationPhotoSlot {
  idFront(
    label: 'ID card: front',
    hint: 'All corners visible, text readable',
    icon: Icons.badge_outlined,
    source: ImageSource.gallery,
  ),
  idBack(
    label: 'ID card: back',
    hint: 'Flat, in good light, no glare',
    icon: Icons.credit_card_rounded,
    source: ImageSource.gallery,
  ),
  selfie(
    label: 'Selfie',
    hint: 'Your face, clearly visible, taken now',
    icon: Icons.face_rounded,
    source: ImageSource.camera,
  );

  const VerificationPhotoSlot({
    required this.label,
    required this.hint,
    required this.icon,
    required this.source,
  });

  final String label;
  final String hint;
  final IconData icon;
  final ImageSource source;
}
