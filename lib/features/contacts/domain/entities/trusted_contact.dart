import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sheshield/core/utils/json_converters.dart';

part 'trusted_contact.freezed.dart';
part 'trusted_contact.g.dart';

/// A trusted contact as stored by the Go backend. Field names/JSON tags
/// mirror `contact.Contact` exactly (id, name, relation, phone,
/// countryCode, createdAt) -- generated, so no field can be silently
/// dropped between read and write (the defect this was built to fix).
@freezed
class TrustedContact with _$TrustedContact {
  const TrustedContact._();

  const factory TrustedContact({
    required String id,
    required String name,
    required String relation,
    required String phone,
    required String countryCode,
    @DateTimeConverter() required DateTime createdAt,
  }) = _TrustedContact;

  factory TrustedContact.fromJson(Map<String, dynamic> json) =>
      _$TrustedContactFromJson(json);

  String get fullPhone => '$countryCode $phone';

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}