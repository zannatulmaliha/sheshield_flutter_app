import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/contacts/domain/entities/trusted_contact.dart';

part 'trusted_contact_model.freezed.dart';
part 'trusted_contact_model.g.dart';

/// Wire shape of the backend's `contact.Contact`. Generated, so no field
/// can be silently dropped between a read and a cache write.
@freezed
class TrustedContactModel with _$TrustedContactModel {
  const TrustedContactModel._();

  const factory TrustedContactModel({
    required String id,
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
    @DateTimeConverter() required DateTime createdAt,
    String? linkedUserUid,
  }) = _TrustedContactModel;

  factory TrustedContactModel.fromJson(Map<String, dynamic> json) =>
      _$TrustedContactModelFromJson(json);

  TrustedContact toEntity() => TrustedContact(
        id: id,
        name: name,
        relation: relation,
        phone: phone,
        countryCode: countryCode,
        createdAt: createdAt,
        linkedUserUid: linkedUserUid,
      );
}
