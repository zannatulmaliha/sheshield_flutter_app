import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/verification/data/models/verification_status_model.dart';
import 'package:sheshield/features/verification/domain/entities/verification_status.dart';

void main() {
  test('maps a rejected response with its reviewer note', () {
    final status = VerificationStatusModel.fromJson({
      'status': 'rejected',
      'note': 'Photo is blurry',
      'submittedAt': '2026-10-01T08:00:00Z',
    }).toEntity();

    expect(status.status, VerificationState.rejected);
    expect(status.note, 'Photo is blurry');
    expect(status.submittedAt, isNotNull);
  });

  test('missing or unknown status falls back to none', () {
    expect(
      VerificationStatusModel.fromJson(const {}).toEntity().status,
      VerificationState.none,
    );
    expect(VerificationState.fromWireValue('???'), VerificationState.none);
  });
}
