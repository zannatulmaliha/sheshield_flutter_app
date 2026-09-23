import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import '../providers/checkin_provider.dart';

/// Opened from the "Check-In Timer" quick action. If a countdown is already
/// running it shows how long is left with a cancel button instead of
/// letting a second one be started on top of it.
Future<void> showCheckInSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _CheckInSheetBody(),
  );
}

class _CheckInSheetBody extends ConsumerStatefulWidget {
  const _CheckInSheetBody();

  @override
  ConsumerState<_CheckInSheetBody> createState() => _CheckInSheetBodyState();
}

class _CheckInSheetBodyState extends ConsumerState<_CheckInSheetBody> {
  int _minutes = 15;

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final checkIn = ref.watch(checkInControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.18),
        ),
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
              child: const Icon(
                Icons.timer_outlined,
                color: AppTheme.accentPurple,
                size: 32,
              ),
            ),
            const SizedBox(height: 18),
            if (checkIn.status == CheckInStatus.running)
              ..._runningContent(checkIn, l10n, colors)
            else
              ..._pickerContent(l10n, colors),
          ],
        ),
      ),
    );
  }

  List<Widget> _runningContent(CheckInState checkIn, AppLocalizations l10n, AppPalette colors) {
    final minutes = checkIn.remainingSeconds ~/ 60;
    final seconds = checkIn.remainingSeconds % 60;
    final time = '${minutes}m ${seconds.toString().padLeft(2, '0')}s';
    return [
      Text(
        l10n.checkInAlreadyRunningTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      const SizedBox(height: 8),
      Text(
        l10n.checkInAlreadyRunningBody(time),
        textAlign: TextAlign.center,
        style: TextStyle(color: colors.textSecondary, fontSize: 13),
      ),
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.success,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () {
            ref.read(checkInControllerProvider.notifier).checkIn();
            Navigator.of(context).pop();
          },
          child: Text(l10n.checkInImSafeCancel, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      ),
    ];
  }

  List<Widget> _pickerContent(AppLocalizations l10n, AppPalette colors) {
    const options = [5, 15, 30, 60];
    return [
      Text(
        l10n.checkInSheetTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
      ),
      const SizedBox(height: 8),
      Text(
        l10n.checkInSheetBody,
        textAlign: TextAlign.center,
        style: TextStyle(color: colors.textSecondary, fontSize: 13),
      ),
      const SizedBox(height: 20),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          for (final m in options)
            ChoiceChip(
              label: Text('$m min'),
              selected: _minutes == m,
              onSelected: (_) => setState(() => _minutes = m),
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: _minutes == m ? Colors.white : colors.textPrimary,
              ),
              selectedColor: AppTheme.accentPurple,
              backgroundColor: colors.chipBackground,
              showCheckmark: false,
            ),
        ],
      ),
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.accentPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: () {
            ref.read(checkInControllerProvider.notifier).start(Duration(minutes: _minutes));
            Navigator.of(context).pop();
          },
          child: Text(l10n.checkInStartButton(_minutes), style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      ),
    ];
  }
}
