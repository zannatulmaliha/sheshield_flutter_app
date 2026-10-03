import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_invite.freezed.dart';

/// A short-lived code a trusted contact enters (after installing the app
/// and signing up) to link their own account. Shown once, never cached.
@freezed
class ContactInvite with _$ContactInvite {
  const factory ContactInvite({
    required String code,
    required DateTime expiresAt,
  }) = _ContactInvite;
}
