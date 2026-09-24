/// Report categories shown in the picker. The backend stores category as a
/// free-form string (internal/report/model.go), so this enum is a Flutter-
/// side convenience for a consistent picker, not a server-enforced set.
enum ReportCategory {
  harassment('harassment', 'Harassment or inappropriate behavior'),
  unsafeBehavior('unsafe_behavior', 'Unsafe or reckless behavior'),
  didNotShowUp('did_not_show_up', "Accepted but never showed up"),
  falseAlarm('false_alarm', 'This was not a real emergency'),
  other('other', 'Something else');

  const ReportCategory(this.key, this.label);
  final String key;
  final String label;
}
