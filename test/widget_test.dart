import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/core/app/sheshield_app.dart';

void main() {
  testWidgets('SheShield app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SheShieldApp());

    await tester.pump();
  });
}