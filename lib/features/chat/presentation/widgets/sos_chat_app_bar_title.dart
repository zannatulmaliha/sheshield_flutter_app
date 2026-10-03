import 'package:flutter/material.dart';

class SosChatAppBarTitle extends StatelessWidget {
  const SosChatAppBarTitle({super.key, required this.sosId, required this.iAmHelper});

  final String sosId;
  final bool iAmHelper;

  /// Both phones show the same short code, so two people can confirm they
  /// are in the same chat.
  String get _shortCode =>
      sosId.length > 4 ? sosId.substring(sosId.length - 4) : sosId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chat with ${iAmHelper ? 'person in need' : 'your helper'}'),
        Text(
          'SOS #$_shortCode',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
