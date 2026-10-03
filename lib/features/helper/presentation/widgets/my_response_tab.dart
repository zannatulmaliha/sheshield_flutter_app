import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/helper/presentation/providers/helper_activity_providers.dart';
import 'package:sheshield/features/helper/presentation/widgets/helper_response_view.dart';

/// Second tab of the Alerts screen: the alert this helper currently holds.
class MyResponseTab extends ConsumerWidget {
  const MyResponseTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return ref.watch(myResponseProvider).when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text(describeErrorForUser(error))),
          data: (response) => response == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      'You are not responding to an alert right now.',
                      style: TextStyle(color: palette.textSecondary),
                    ),
                  ),
                )
              : HelperResponseView(
                  key: ValueKey(response.alert.id),
                  alert: response.alert,
                  initialStage: response.stage,
                  onEnded: () => ref.invalidate(myResponseProvider),
                ),
        );
  }
}
