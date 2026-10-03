import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_activity_providers.dart';
import 'package:sheshield/features/helper/presentation/widgets/helper_history_card.dart';

/// Past responses for the History tab.
class HelperHistoryScreen extends ConsumerWidget {
  const HelperHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(helperHistoryProvider.future),
      child: ref.watch(helperHistoryProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ListView(
              padding: const EdgeInsets.all(32),
              children: [Center(child: Text(describeErrorForUser(error)))],
            ),
            data: (items) => items.isEmpty
                ? ListView(
                    padding: const EdgeInsets.all(48),
                    children: [
                      Center(
                        child: Text(
                          'No responses yet.\nAlerts you accept will show up here.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: palette.textSecondary),
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 110),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, index) =>
                        HelperHistoryCard(item: items[index], palette: palette),
                  ),
          ),
    );
  }
}
