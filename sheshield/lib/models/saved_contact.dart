import 'package:flutter/material.dart';

/// A trusted contact stored on the backend. (Separate from the demo-only
/// [TrustedContact] in trusted_contact.dart, which is left untouched.)
class SavedContact {
  const SavedContact({
    required this.id,
    required this.name,
    required this.relation,
    required this.phone,
    required this.countryCode,
  });

  final String id;
  final String name;
  final String relation;
  final String phone;
  final String countryCode;

  factory SavedContact.fromJson(Map<String, dynamic> json) => SavedContact(
        id: json['id'] as String,
        name: json['name'] as String,
        relation: (json['relation'] as String?) ?? '',
        phone: json['phone'] as String,
        countryCode: (json['countryCode'] as String?) ?? '',
      );

  String get displayPhone => countryCode.isEmpty ? phone : '$countryCode $phone';

  /// e.g. "Mother · +880 1712345678", or just the number if no relation.
  String get subtitle => relation.isEmpty ? displayPhone : '$relation · $displayPhone';

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  static const _palette = [
    Color(0xFFFF8FA3),
    Color(0xFF7B2FF7),
    Color(0xFF3F5EFB),
    Color(0xFF2FC28E),
  ];

  /// Same contact always gets the same avatar colour. Summing code units
  /// (rather than String.hashCode) keeps it stable across runs and platforms.
  Color get color {
    final sum = id.codeUnits.fold<int>(0, (a, b) => a + b);
    return _palette[sum % _palette.length];
  }
}
