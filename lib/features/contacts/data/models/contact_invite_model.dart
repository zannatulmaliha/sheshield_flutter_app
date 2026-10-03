import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';
import 'package:sheshield/features/contacts/domain/entities/contact_invite.dart';

part 'contact_invite_model.freezed.dart';
part 'contact_invite_model.g.dart';

/// Wire shape of `POST /contacts/{id}/invite` -> `{ code, expiresAt }`.
@freezed
class ContactInviteModel with _$ContactInviteModel {
  const ContactInviteModel._();

  const factory ContactInviteModel({
    required String code,
    @DateTimeConverter() required DateTime expiresAt,
  }) = _ContactInviteModel;

  factory ContactInviteModel.fromJson(Map<String, dynamic> json) =>
      _$ContactInviteModelFromJson(json);

  ContactInvite toEntity() => ContactInvite(code: code, expiresAt: expiresAt);
}
