import 'package:flutter/material.dart';

extension SnackBarContext on BuildContext {
  /// Shows [message] in a snackbar. Callers check `context.mounted` first
  /// when they call this after an `await`.
  void showMessage(String message) => ScaffoldMessenger.of(this)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
