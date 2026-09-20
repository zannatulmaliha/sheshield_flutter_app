import 'package:flutter/material.dart';

class HelperAlert {
  const HelperAlert({
    required this.id,
    required this.label,
    required this.distanceKm,
    required this.minutesAgo,
    required this.color,
  });

  final int id;
  final String label;
  final double distanceKm;
  final int minutesAgo;
  final Color color;
}

const List<HelperAlert> demoHelperAlerts = [
  HelperAlert(id: 1, label: 'Anonymous Guardian', distanceKm: 0.6, minutesAgo: 2, color: Color(0xFFFF4B6E)),
  HelperAlert(id: 2, label: 'Anonymous Guardian', distanceKm: 1.4, minutesAgo: 6, color: Color(0xFFFFA94D)),
  HelperAlert(id: 3, label: 'Anonymous Guardian', distanceKm: 2.1, minutesAgo: 11, color: Color(0xFF3F5EFB)),
];
