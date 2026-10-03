import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/contacts/presentation/providers/trusted_contacts_provider.dart';
import 'package:sheshield/features/contacts/presentation/widgets/add_contact_sheet.dart';
import 'package:sheshield/features/contacts/presentation/widgets/contacts_coverage_banner.dart';
import 'package:sheshield/features/contacts/presentation/widgets/contacts_header.dart';
import 'package:sheshield/features/contacts/presentation/widgets/trusted_contacts_list.dart';
import 'package:sheshield/shared/widgets/staggered_fade_in.dart';

/// Trusted-contacts tab, backed by [trustedContactsControllerProvider].
class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => ref.refresh(trustedContactsControllerProvider.future),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 140),
              children: [
                StaggeredFadeIn(
                  children: [
                    ContactsHeader(palette: palette),
                    const SizedBox(height: 20),
                    ContactsCoverageBanner(palette: palette),
                    const SizedBox(height: 20),
                    TrustedContactsList(palette: palette),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 4,
            bottom: 140,
            child: FloatingActionButton.extended(
              onPressed: () => showAddContactSheet(context),
              backgroundColor: palette.primary,
              icon: const Icon(Icons.person_add_alt_1_rounded),
              label: const Text(
                'Add Contact',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
