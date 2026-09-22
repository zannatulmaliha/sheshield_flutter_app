/// One selectable country in [CountryCodePicker]. [minDigits]/[maxDigits]
/// are the local (national, no dial code) subscriber-number length used
/// for validation -- deliberately a *range* rather than one fixed
/// number, since most countries allow more than one valid length (e.g.
/// a landline vs a mobile number).
class CountryDialCode {
  const CountryDialCode({
    required this.isoCode,
    required this.name,
    required this.dialCode,
    required this.flagEmoji,
    required this.minDigits,
    required this.maxDigits,
  });

  final String isoCode;
  final String name;
  final String dialCode; // e.g. "+880"
  final String flagEmoji;
  final int minDigits;
  final int maxDigits;

  bool isValidLocalNumber(String digitsOnly) =>
      digitsOnly.length >= minDigits && digitsOnly.length <= maxDigits;

  static const bangladesh = CountryDialCode(
    isoCode: 'BD',
    name: 'Bangladesh',
    dialCode: '+880',
    flagEmoji: '🇧🇩',
    minDigits: 10,
    maxDigits: 10,
  );

  /// A small, curated list -- enough to cover this app's initial
  /// rollout markets without pulling in a full ISO-3166 package. Add
  /// entries here as new markets launch; [CountryCodePicker] needs no
  /// other change.
  static const all = <CountryDialCode>[
    bangladesh,
    CountryDialCode(
      isoCode: 'IN',
      name: 'India',
      dialCode: '+91',
      flagEmoji: '🇮🇳',
      minDigits: 10,
      maxDigits: 10,
    ),
    CountryDialCode(
      isoCode: 'PK',
      name: 'Pakistan',
      dialCode: '+92',
      flagEmoji: '🇵🇰',
      minDigits: 10,
      maxDigits: 10,
    ),
    CountryDialCode(
      isoCode: 'US',
      name: 'United States',
      dialCode: '+1',
      flagEmoji: '🇺🇸',
      minDigits: 10,
      maxDigits: 10,
    ),
    CountryDialCode(
      isoCode: 'GB',
      name: 'United Kingdom',
      dialCode: '+44',
      flagEmoji: '🇬🇧',
      minDigits: 10,
      maxDigits: 10,
    ),
    CountryDialCode(
      isoCode: 'AE',
      name: 'United Arab Emirates',
      dialCode: '+971',
      flagEmoji: '🇦🇪',
      minDigits: 8,
      maxDigits: 9,
    ),
    CountryDialCode(
      isoCode: 'SA',
      name: 'Saudi Arabia',
      dialCode: '+966',
      flagEmoji: '🇸🇦',
      minDigits: 9,
      maxDigits: 9,
    ),
    CountryDialCode(
      isoCode: 'MY',
      name: 'Malaysia',
      dialCode: '+60',
      flagEmoji: '🇲🇾',
      minDigits: 9,
      maxDigits: 10,
    ),
    CountryDialCode(
      isoCode: 'SG',
      name: 'Singapore',
      dialCode: '+65',
      flagEmoji: '🇸🇬',
      minDigits: 8,
      maxDigits: 8,
    ),
  ];
}
