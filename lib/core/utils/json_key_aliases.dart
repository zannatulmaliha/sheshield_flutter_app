/// Rewrites known alternate keys (e.g. Go structs serialized without json
/// tags, so `NIDFront` instead of `nidFront`) to the canonical key a
/// generated `fromJson` expects. Keys already canonical pass through.
Map<String, dynamic> applyJsonKeyAliases(
  Map<String, dynamic> json,
  Map<String, String> aliasToCanonicalKey,
) =>
    json.map(
      (key, value) => MapEntry(aliasToCanonicalKey[key] ?? key, value),
    );
