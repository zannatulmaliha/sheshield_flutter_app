import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import 'package:sheshield/features/user/presentation/providers/checkin_provider.dart';
import 'package:sheshield/features/user/presentation/widgets/checkin_picker_content.dart';
import 'package:sheshield/features/user/presentation/widgets/checkin_running_content.dart';
import 'package:sheshield/features/user/presentation/widgets/sheet_container.dart';

/// Opened from the "Check-In Timer" quick action. If a countdown is already
/// running it shows how long is left with a cancel button instead of letting
/// a second one start on top of it.
Future<void> showCheckInSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const CheckInSheet(),
  );
}

class CheckInSheet extends HookConsumerWidget {
  const CheckInSheet({super.key});

  static const _defaultMinutes = 15;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final checkIn = ref.watch(checkInControllerProvider);
    final controller = ref.read(checkInControllerProvider.notifier);
    final selectedMinutes = useState(_defaultMinutes);

    return SheetContainer(
      palette: palette,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 42,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.accentPurple.withValues(alpha: 0.12),
            ),
            child: const Icon(Icons.timer_outlined, color: AppTheme.accentPurple, size: 32),
          ),
          const SizedBox(height: 18),
          if (checkIn.status == CheckInStatus.running)
            CheckInRunningContent(
              checkIn: checkIn,
              palette: palette,
              onImSafe: () {
                controller.checkIn();
                Navigator.of(context).pop();
              },
            )
          else
            CheckInPickerContent(
              selectedMinutes: selectedMinutes.value,
              palette: palette,
              onMinutesSelected: (minutes) => selectedMinutes.value = minutes,
              onStart: () {
                controller.start(Duration(minutes: selectedMinutes.value));
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
