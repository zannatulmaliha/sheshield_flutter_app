import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/app/sheshield_app.dart';
import 'package:sheshield/core/config/app_config.dart';
import 'package:sheshield/core/config/app_config_provider.dart';

void main() {
  testWidgets('SheShield app loads', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appConfigProvider.overrideWithValue(AppConfig.dev)],
        child: const SheShieldApp(),
      ),
    );

    await tester.pump();
  });
}
