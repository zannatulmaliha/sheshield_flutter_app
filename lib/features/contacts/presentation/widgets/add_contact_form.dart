import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/constants/country_dial_codes.dart';
import 'package:sheshield/core/hooks/use_async_action.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/core/utils/context_extensions.dart';
import 'package:sheshield/features/auth/presentation/widgets/country_code_picker.dart';
import 'package:sheshield/features/contacts/presentation/providers/trusted_contacts_provider.dart';

/// Name / relation / phone form; pops the sheet once the contact is saved.
class AddContactForm extends HookConsumerWidget {
  const AddContactForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = resolvePalette(context, ref);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final nameController = useTextEditingController();
    final relationController = useTextEditingController();
    final phoneController = useTextEditingController();
    final country = useState(CountryDialCode.bangladesh);
    final saveAction = useAsyncAction();

    Future<void> saveContact() async {
      if (!formKey.currentState!.validate()) return;
      final wasSaved = await saveAction.run(
        () => ref.read(trustedContactsControllerProvider.notifier).addContact(
              name: nameController.text.trim(),
              relation: relationController.text.trim(),
              phone: phoneController.text.trim(),
              countryCode: country.value.dialCode,
            ),
        onFailure: context.showMessage,
      );
      if (wasSaved && context.mounted) Navigator.of(context).pop();
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add Trusted Contact', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Name is required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: relationController,
            decoration: const InputDecoration(labelText: 'Relation (e.g. Mother)'),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CountryCodePicker(
                value: country.value,
                onChanged: (selected) => country.value = selected,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                  validator: (value) {
                    final digits = (value ?? '').replaceAll(RegExp(r'\D'), '');
                    return country.value.isValidLocalNumber(digits)
                        ? null
                        : 'Invalid number for ${country.value.name}';
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveAction.isRunning ? null : saveContact,
            style: ElevatedButton.styleFrom(
              backgroundColor: palette.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: saveAction.isRunning
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Save Contact', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }
}
