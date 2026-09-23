import 'package:flutter/material.dart';

/// A "Guardian Level" achievement badge, earned by using SheShield's
/// real safety features. Ported from the UI_Screens prototype's
/// `AppBadge`/`allBadges` -- descriptions adjusted to describe real
/// actions instead of demo-only ones.
class AppBadge {
  const AppBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

const List<AppBadge> allBadges = [
  AppBadge(
    id: 'first_step',
    title: 'First Step',
    description: 'Set up your SheShield profile.',
    icon: Icons.emoji_events_rounded,
    color: Color(0xFFFFA94D),
  ),
  AppBadge(
    id: 'circle_starter',
    title: 'Circle Starter',
    description: 'Added your first trusted contact.',
    icon: Icons.diversity_3_rounded,
    color: Color(0xFF3F5EFB),
  ),
  AppBadge(
    id: 'circle_guardian',
    title: 'Circle Guardian',
    description: 'Built a circle of 5+ trusted contacts.',
    icon: Icons.shield_moon_rounded,
    color: Color(0xFF2FC28E),
  ),
  AppBadge(
    id: 'ninja_reflexes',
    title: 'Ninja Reflexes',
    description: 'Sent your first SOS alert.',
    icon: Icons.sports_martial_arts_rounded,
    color: Color(0xFFFF2E7E),
  ),
  AppBadge(
    id: 'ai_sentinel',
    title: 'AI Sentinel',
    description: 'Activated every AI Guardian feature.',
    icon: Icons.psychology_rounded,
    color: Color(0xFFB83280),
  ),
  AppBadge(
    id: 'guardian_helper',
    title: 'Guardian Helper',
    description: 'Responded to your first SOS alert as a helper.',
    icon: Icons.volunteer_activism_rounded,
    color: Color(0xFF3F5EFB),
  ),
];
