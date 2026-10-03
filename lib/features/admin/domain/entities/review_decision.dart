/// A reviewer's verdict on a report. Wire values match the backend's
/// `report.ReviewRequest.Status`.
enum ReviewDecision {
  dismissed('dismissed'),
  actioned('actioned');

  const ReviewDecision(this.wireValue);

  final String wireValue;
}
