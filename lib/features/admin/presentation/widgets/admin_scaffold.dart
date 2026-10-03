import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// Scaffold + app bar styling shared by every admin screen.
class AdminScaffold extends ConsumerWidget {
  const AdminScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions = const [],
  });

  final String title;
  final Widget body;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
        actions: actions,
      ),
      body: body,
    );
  }
}
