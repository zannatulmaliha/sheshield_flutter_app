/// The three build flavors the app ships as.
enum AppFlavor {
  dev,
  staging,
  production;

  bool get isProduction => this == AppFlavor.production;

  /// Suffix shown next to the app name so test builds are never mistaken
  /// for the real app.
  String get displaySuffix => switch (this) {
        AppFlavor.dev => ' (Dev)',
        AppFlavor.staging => ' (Staging)',
        AppFlavor.production => '',
      };
}
