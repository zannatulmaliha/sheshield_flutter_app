import 'package:flutter/widgets.dart';
import 'game_state.dart';

/// Makes a single [GameState] available anywhere below it in the tree —
/// including pushed routes, since it's installed via [MaterialApp.builder]
/// as an ancestor of the app's Navigator.
class GameScope extends InheritedNotifier<GameState> {
  const GameScope({super.key, required GameState state, required super.child}) : super(notifier: state);

  /// Use in `build()` — subscribes the caller to rebuild on changes.
  static GameState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<GameScope>();
    assert(scope != null, 'No GameScope found in context');
    return scope!.notifier!;
  }

  /// Use in callbacks/event handlers — reads the state without subscribing.
  static GameState read(BuildContext context) {
    final element = context.getElementForInheritedWidgetOfExactType<GameScope>();
    final scope = element?.widget as GameScope?;
    assert(scope != null, 'No GameScope found in context');
    return scope!.notifier!;
  }
}
