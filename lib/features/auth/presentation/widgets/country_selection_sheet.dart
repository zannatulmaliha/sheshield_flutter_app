import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/constants/country_dial_codes.dart';
import 'package:sheshield/core/theme/app_palette.dart';

/// Searchable list of countries; pops the chosen [CountryDialCode].
class CountrySelectionSheet extends HookConsumerWidget {
  const CountrySelectionSheet({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final query = useState('');
    final searchText = query.value.trim().toLowerCase();
    final matches = CountryDialCode.all
        .where(
          (country) =>
              searchText.isEmpty ||
              country.name.toLowerCase().contains(searchText) ||
              country.dialCode.contains(searchText),
        )
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: palette.surface,
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
                  title,
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: TextStyle(color: palette.textPrimary),
                  onChanged: (text) => query.value = text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: palette.chipBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: palette.textSecondary),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: palette.textSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    final country = matches[index];
                    return ListTile(
                      leading: Text(country.flagEmoji, style: const TextStyle(fontSize: 20)),
                      title: Text(country.name, style: TextStyle(color: palette.textPrimary)),
                      trailing: Text(
                        country.dialCode,
                        style: TextStyle(
                          color: palette.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () => Navigator.of(context).pop(country),
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
