import 'package:flutter_test/flutter_test.dart';
import 'package:sheshield/features/admin/data/models/admin_verification_model.dart';

void main() {
  test('reads PascalCase keys from the untagged Go struct', () {
    final model = AdminVerificationModel.fromJson({
      'ID': 'v1',
      'UserUID': 'u1',
      'Status': 'pending',
      'CreatedAt': '2026-10-01T08:00:00Z',
      'UserName': 'Amina',
    });

    final entity = model.toEntity();
    expect(entity.id, 'v1');
    expect(entity.userUid, 'u1');
    expect(entity.isPending, isTrue);
    expect(entity.displayName, 'Amina');
  });

  test('reads camelCase keys and falls back to uid when name is empty', () {
    final entity = AdminVerificationModel.fromJson({
      'id': 'v2',
      'userUid': 'u2',
      'status': 'approved',
      'createdAt': '2026-10-01T08:00:00Z',
    }).toEntity();

    expect(entity.isPending, isFalse);
    expect(entity.displayName, 'u2');
  });
}
