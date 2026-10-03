/// How far a helper has got with the alert they hold. Declaration order is
/// the order they happen in, so `index` comparisons mean "further along".
enum ResponseStage {
  none('', 'Accepted'),
  enRoute('en_route', 'En route'),
  arrived('arrived', 'Arrived'),
  assisting('assisting', 'Assisting');

  const ResponseStage(this.wireValue, this.label);

  final String wireValue;
  final String label;

  bool hasReached(ResponseStage other) => index >= other.index;

  static ResponseStage fromWireValue(String? value) => ResponseStage.values
      .firstWhere((stage) => stage.wireValue == value, orElse: () => none);
}
