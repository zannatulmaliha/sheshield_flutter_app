import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'gamification_provider.g.dart';

/// Guardian Level progress: XP and unlocked achievement badges.
class GamificationState {
  const GamificationState({required this.xp, required this.unlockedBadgeIds});

  static const xpPerLevel = 100;

  static const List<String> tierTitles = [
    'Rookie Guardian',
    'Bold Defender',
    'Fierce Protector',
    'Ninja Sentinel',
    'Unstoppable Warrior',
  ];

  final int xp;
  final Set<String> unlockedBadgeIds;

  int get level => 1 + (xp ~/ xpPerLevel);
  int get xpIntoLevel => xp % xpPerLevel;
  double get progress => xpIntoLevel / xpPerLevel;
  String get tierTitle => tierTitles[(level - 1).clamp(0, tierTitles.length - 1)];

  bool hasBadge(String id) => unlockedBadgeIds.contains(id);

  GamificationState copyWith({int? xp, Set<String>? unlockedBadgeIds}) {
    return GamificationState(
      xp: xp ?? this.xp,
      unlockedBadgeIds: unlockedBadgeIds ?? this.unlockedBadgeIds,
    );
  }
}

/// Local, in-session "Guardian Level" progress earned by using the
/// app's real safety features (adding contacts, sending an SOS,
/// responding as a helper...). Ported from the UI_Screens prototype's
/// `GameState`/`GameScope`, rebuilt on Riverpod to match this app's
/// state management instead of an `InheritedNotifier`. Not persisted
/// or backed by the server -- resets when the app restarts, same as
/// on the branch this was ported from.
@Riverpod(keepAlive: true)
class GamificationController extends _$GamificationController {
  @override
  GamificationState build() =>
      const GamificationState(xp: 0, unlockedBadgeIds: {'first_step'});

  /// Adds XP and returns true if this pushed the player up a level.
  bool addXp(int amount) {
    final beforeLevel = state.level;
    state = state.copyWith(xp: state.xp + amount);
    return state.level > beforeLevel;
  }

  /// Returns true if this badge was newly unlocked (false if already held).
  bool unlockBadge(String id) {
    if (state.unlockedBadgeIds.contains(id)) return false;
    state = state.copyWith(unlockedBadgeIds: {...state.unlockedBadgeIds, id});
    return true;
  }
}
