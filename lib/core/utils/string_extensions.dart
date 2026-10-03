extension NullIfEmptyString on String? {
  /// The backend sends empty strings for "absent" optional text fields.
  String? get nullIfEmpty {
    final value = this;
    return (value == null || value.isEmpty) ? null : value;
  }
}
