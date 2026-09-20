import 'package:flutter/material.dart';

class TrustedContact {
  const TrustedContact({
    required this.name,
    required this.relation,
    required this.phone,
    required this.color,
    this.isPrimary = false,
  });

  final String name;
  final String relation;
  final String phone;
  final Color color;
  final bool isPrimary;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }
}

final List<TrustedContact> demoContacts = [
  const TrustedContact(
    name: 'Ayesha Rahman',
    relation: 'Mother',
    phone: '+880 171 234 5678',
    color: Color(0xFFFF8FA3),
    isPrimary: true,
  ),
  const TrustedContact(
    name: 'Tanvir Ahmed',
    relation: 'Brother',
    phone: '+880 191 876 5432',
    color: Color(0xFF7B2FF7),
    isPrimary: true,
  ),
  const TrustedContact(
    name: 'Nusrat Jahan',
    relation: 'Best Friend',
    phone: '+880 155 222 3344',
    color: Color(0xFF3F5EFB),
  ),
  const TrustedContact(
    name: 'Dr. Kamal Hossain',
    relation: 'Family Doctor',
    phone: '+880 133 998 8776',
    color: Color(0xFF2FC28E),
  ),
];
