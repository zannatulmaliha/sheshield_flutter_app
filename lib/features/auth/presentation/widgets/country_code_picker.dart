import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sheshield/core/constants/country_dial_codes.dart';
import 'package:sheshield/core/l10n/app_localizations.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// The signup form's country/dial-code field -- a searchable bottom
/// sheet rather than a free-text box, so [CountryDialCode.dialCode]
/// (used both to prefix the phone number shown to the person and as
/// the raw value sent to the backend) can never be mistyped, and so
/// [SignupAccountFields]'s phone validator can check the right
/// digit-length range for whichever country is selected.
class CountryCodePicker extends ConsumerWidget {
  const CountryCodePicker({super.key, required this.value, required this.onChanged});

  final CountryDialCode value;
  final ValueChanged<CountryDialCode> onChanged;

  Future<void> _open(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final picked = await showModalBottomSheet<CountryDialCode>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _CountrySheet(title: l10n.selectCountry),
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = resolvePalette(context, ref);
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => _open(context),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colors.surface,
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
              style: TextStyle(color: colors.textPrimary, fontWeight: FontWeight.w700),
            ),
            Icon(Icons.expand_more_rounded, color: colors.textSecondary, size: 18),
          ],
        ),
      ),
    );
  }
}

class _CountrySheet extends ConsumerStatefulWidget {
  const _CountrySheet({required this.title});
  final String title;

  @override
  ConsumerState<_CountrySheet> createState() => _CountrySheetState();
}

class _CountrySheetState extends ConsumerState<_CountrySheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);
    final results = CountryDialCode.all.where((c) {
      final q = _query.trim().toLowerCase();
      if (q.isEmpty) return true;
      return c.name.toLowerCase().contains(q) || c.dialCode.contains(q);
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  autofocus: false,
                  style: TextStyle(color: colors.textPrimary),
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: colors.chipBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: colors.textSecondary),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: colors.textSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.length,
                  itemBuilder: (ctx, i) {
                    final c = results[i];
                    return ListTile(
                      leading: Text(c.flagEmoji, style: const TextStyle(fontSize: 20)),
                      title: Text(c.name, style: TextStyle(color: colors.textPrimary)),
                      trailing: Text(
                        c.dialCode,
                        style: TextStyle(color: colors.textSecondary, fontWeight: FontWeight.w700),
                      ),
                      onTap: () => Navigator.of(context).pop(c),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
