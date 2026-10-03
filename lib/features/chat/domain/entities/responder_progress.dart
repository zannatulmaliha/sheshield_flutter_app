/// How far a helper has got, as the person in danger may know it.
enum ResponderProgress {
  none(''),
  enRoute('en_route'),
  arrived('arrived'),
  assisting('assisting');

  const ResponderProgress(this.wireValue);

  final String wireValue;

  static ResponderProgress fromWireValue(String? value) =>
      ResponderProgress.values.firstWhere(
        (progress) => progress.wireValue == value,
        orElse: () => none,
      );
}
