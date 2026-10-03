/// A deliberately simple heuristic: late-night hours read as riskier. No
/// location or route data is used.
enum TimeOfDayRisk {
  low('Low'),
  medium('Medium'),
  high('High');

  const TimeOfDayRisk(this.label);

  final String label;

  static TimeOfDayRisk at(DateTime moment) {
    final hour = moment.hour;
    if (hour >= 22 || hour < 5) return high;
    if (hour >= 19 || hour < 7) return medium;
    return low;
  }
}
