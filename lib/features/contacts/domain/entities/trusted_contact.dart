import 'package:freezed_annotation/freezed_annotation.dart';

part 'trusted_contact.freezed.dart';

/// A person who is notified when the user sends an SOS.
@freezed
class TrustedContact with _$TrustedContact {
  const TrustedContact._();

  const factory TrustedContact({
    required String id,
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
    required DateTime createdAt,

    /// Set once the contact accepts an invite from their own SheShield
    /// account. Null means they can only be reached by SMS.
    String? linkedUserUid,
  }) = _TrustedContact;

  String get fullPhone => '$countryCode $phone';

  bool get hasAppLinked => linkedUserUid != null;

  String get initials {
    final nameParts = name.trim().split(RegExp(r'\s+'));
    if (nameParts.first.isEmpty) return '?';
    final firstInitial = nameParts.first[0];
    if (nameParts.length == 1) return firstInitial.toUpperCase();
    return (firstInitial + nameParts.last[0]).toUpperCase();
  }
}
