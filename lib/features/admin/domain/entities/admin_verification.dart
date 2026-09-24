class AdminVerification {
  const AdminVerification({
    required this.id,
    required this.userUid,
    required this.status,
    required this.nidFront,
    required this.nidBack,
    required this.selfie,
    required this.note,
    required this.createdAt,
    this.reviewedAt,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userType,
  });

  final String id;
  final String userUid;
  final String status;
  final String nidFront;
  final String nidBack;
  final String selfie;
  final String note;
  final DateTime createdAt;
  final DateTime? reviewedAt;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userType;

  factory AdminVerification.fromJson(Map<String, dynamic> json) {
    String stringValue(String upperKey, String lowerKey) {
      final value = json[upperKey] ?? json[lowerKey];
      return value?.toString() ?? '';
    }

    DateTime parseDate(String upperKey, String lowerKey) {
      final value = json[upperKey] ?? json[lowerKey];

      if (value == null) {
        return DateTime.now();
      }

      return DateTime.tryParse(value.toString()) ?? DateTime.now();
    }

    DateTime? parseNullableDate(String upperKey, String lowerKey) {
      final value = json[upperKey] ?? json[lowerKey];

      if (value == null || value.toString().isEmpty) {
        return null;
      }

      return DateTime.tryParse(value.toString());
    }

    return AdminVerification(
      id: stringValue('ID', 'id'),
      userUid: stringValue('UserUID', 'userUid'),
      status: stringValue('Status', 'status'),
      nidFront: stringValue('NIDFront', 'nidFront'),
      nidBack: stringValue('NIDBack', 'nidBack'),
      selfie: stringValue('Selfie', 'selfie'),
      note: stringValue('Note', 'note'),
      createdAt: parseDate('CreatedAt', 'createdAt'),
      reviewedAt: parseNullableDate('ReviewedAt', 'reviewedAt'),
      userName: stringValue('UserName', 'userName'),
      userEmail: stringValue('UserEmail', 'userEmail'),
      userPhone: stringValue('UserPhone', 'userPhone'),
      userType: stringValue('UserType', 'userType'),
    );
  }
}
