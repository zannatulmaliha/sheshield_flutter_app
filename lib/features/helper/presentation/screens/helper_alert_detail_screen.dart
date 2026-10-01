import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/domain/entities/accepted_alert.dart';
import '../widgets/helper_response_view.dart';

/// Pushed right after a helper wins the accept race. All behaviour lives in
/// [HelperResponseView] (shared with the Alerts > My Response tab).
class HelperAlertDetailScreen extends ConsumerWidget {
  const HelperAlertDetailScreen({super.key, required this.alert});
  final AcceptedAlert alert;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Respond now'), backgroundColor: colors.surface, foregroundColor: colors.textPrimary),
      body: SafeArea(
        child: HelperResponseView(
          alert: alert,
          onEnded: () {
            if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
