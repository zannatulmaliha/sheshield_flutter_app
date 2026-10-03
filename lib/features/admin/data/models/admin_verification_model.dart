import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/core/utils/json_key_aliases.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';

part 'admin_verification_model.freezed.dart';
part 'admin_verification_model.g.dart';

/// The verification endpoints serialize a Go struct without json tags, so
/// keys may arrive as `UserUID` or as `userUid`. These aliases fold the
/// PascalCase form into the canonical camelCase one.
const _pascalCaseKeyAliases = {
  'ID': 'id',
  'UserUID': 'userUid',
  'Status': 'status',
  'Note': 'note',
  'CreatedAt': 'createdAt',
  'ReviewedAt': 'reviewedAt',
  'UserName': 'userName',
  'UserEmail': 'userEmail',
  'UserPhone': 'userPhone',
  'UserType': 'userType',
};

@freezed
class AdminVerificationModel with _$AdminVerificationModel {
  const AdminVerificationModel._();

  const factory AdminVerificationModel({
    @Default('') String id,
    @Default('') String userUid,
    @Default('') String status,
    @Default('') String note,
    @DateTimeConverter() required DateTime createdAt,
    @Default('') String userName,
    @Default('') String userEmail,
    @Default('') String userPhone,
    @Default('') String userType,
    @NullableDateTimeConverter() DateTime? reviewedAt,
  }) = _AdminVerificationModel;

  factory AdminVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$AdminVerificationModelFromJson(
        applyJsonKeyAliases(json, _pascalCaseKeyAliases),
      );

  AdminVerification toEntity() => AdminVerification(
        id: id,
        userUid: userUid,
        status: status,
        note: note,
        createdAt: createdAt,
        userName: userName,
        userEmail: userEmail,
        userPhone: userPhone,
        userType: userType,
        reviewedAt: reviewedAt,
      );
}
