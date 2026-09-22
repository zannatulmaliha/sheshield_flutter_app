/// A short code, valid for a limited time, that a trusted contact enters
/// (after installing SheShield and signing up) to link their own account --
/// see ContactsRepository.acceptInvite. Not a freezed model: it's a
/// throwaway value shown once on screen, never cached or round-tripped.
class ContactInvite {
  const ContactInvite({required this.code, required this.expiresAt});

  factory ContactInvite.fromJson(Map<String, dynamic> json) => ContactInvite(
        code: json['code'] as String,
        expiresAt: DateTime.parse(json['expiresAt'] as String),
      );

  final String code;
  final DateTime expiresAt;
}
