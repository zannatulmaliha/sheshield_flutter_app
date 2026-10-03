import 'package:sheshield/core/error/app_failure.dart';

const _fallbackMessage = 'Something went wrong. Please try again.';

/// The text to show a person for any caught error. Known failures carry
/// their own message; anything else is deliberately generic so internal
/// exception text never reaches the screen.
String describeErrorForUser(Object error) =>
    error is AppFailure ? error.message : _fallbackMessage;
