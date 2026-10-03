/// Where a moderation report is in review. Wire values match the backend.
enum ReviewStatus {
  pending('pending'),
  reviewing('reviewing'),
  actioned('actioned'),
  dismissed('dismissed');

  const ReviewStatus(this.wireValue);

  final String wireValue;

  bool get isAwaitingDecision =>
      this == ReviewStatus.pending || this == ReviewStatus.reviewing;

  /// Unknown values read as [pending] so a new server status can never hide
  /// a report from the queue.
  static ReviewStatus fromWireValue(String? value) => ReviewStatus.values
      .firstWhere((status) => status.wireValue == value, orElse: () => pending);
}
