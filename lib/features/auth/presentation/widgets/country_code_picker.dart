import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/constants/country_dial_codes.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/auth/presentation/widgets/country_selection_sheet.dart';

/// The country / dial-code field: a searchable bottom sheet rather than a
/// free-text box, so the dial code (shown to the person and sent to the
/// backend) can never be mistyped and the phone validator checks the right
/// digit range for the selected country.
class CountryCodePicker extends ConsumerWidget {
  const CountryCodePicker({super.key, required this.value, required this.onChanged});

  final CountryDialCode value;
  final ValueChanged<CountryDialCode> onChanged;

  Future<void> _openSheet(BuildContext context) async {
    final title = AppLocalizations.of(context).selectCountry;
    final picked = await showModalBottomSheet<CountryDialCode>(
      context: context,
      isScrollControlled: true,
      builder: (_) => CountrySelectionSheet(title: title),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _openSheet(context),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(14),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(value.flagEmoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 6),
            Text(
              value.dialCode,
              style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w700),
            ),
            Icon(Icons.expand_more_rounded, color: palette.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}
