enum VerificationState { none, pending, approved, rejected }

/// Where a helper's verification stands, as decided by the server. The app
/// only ever reads this; nothing here can be changed from the phone.
class VerificationInfo {
  const VerificationInfo({required this.state, this.note = '', this.submittedAt});

  final VerificationState state;

  /// The reviewer's reason. Only present when [state] is rejected.
  final String note;
  final DateTime? submittedAt;

  factory VerificationInfo.fromJson(Map<String, dynamic> json) => VerificationInfo(
        state: switch (json['status'] as String) {
          'pending' => VerificationState.pending,
          'approved' => VerificationState.approved,
          'rejected' => VerificationState.rejected,
          _ => VerificationState.none,
        },
        note: (json['note'] as String?) ?? '',
        submittedAt: json['submittedAt'] == null ? null : DateTime.tryParse(json['submittedAt'] as String),
      );
}
