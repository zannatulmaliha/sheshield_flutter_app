import 'package:flutter/foundation.dart';

/// Tracks the player's Guardian Level progress: XP, streaks and unlocked
/// achievement badges. A lightweight ChangeNotifier — no external state
/// management package needed for a demo this size.
class GameState extends ChangeNotifier {
  GameState({int initialXp = 260, this.streakDays = 6})
      : _xp = initialXp,
        unlockedBadgeIds = {'first_step', 'circle_starter'};

  static const int xpPerLevel = 100;

  static const List<String> tierTitles = [
    'Rookie Guardian',
    'Bold Defender',
    'Fierce Protector',
    'Ninja Sentinel',
    'Unstoppable Warrior',
  ];

  int _xp;
  int streakDays;
  final Set<String> unlockedBadgeIds;
  bool isHelperOnline = false;
  final Set<int> respondedAlertIds = {};

  int get xp => _xp;
  int get level => 1 + (_xp ~/ xpPerLevel);
  int get xpIntoLevel => _xp % xpPerLevel;
  double get progress => xpIntoLevel / xpPerLevel;

  String get tierTitle => tierTitles[(level - 1).clamp(0, tierTitles.length - 1)];

  /// Adds XP and returns true if this pushed the player up a level.
  bool addXp(int amount) {
    final beforeLevel = level;
    _xp += amount;
    final leveledUp = level > beforeLevel;
    notifyListeners();
    return leveledUp;
  }

  bool hasBadge(String id) => unlockedBadgeIds.contains(id);

  /// Returns true if this badge was newly unlocked (false if already held).
  bool unlockBadge(String id) {
    final isNew = unlockedBadgeIds.add(id);
    if (isNew) notifyListeners();
    return isNew;
  }

  void setHelperOnline(bool online) {
    isHelperOnline = online;
    notifyListeners();
  }

  bool hasResponded(int alertId) => respondedAlertIds.contains(alertId);

  /// Returns true if this alert was newly marked responded (false if already).
  bool respondToAlert(int alertId) {
    final isNew = respondedAlertIds.add(alertId);
    if (isNew) notifyListeners();
    return isNew;
  }
}
