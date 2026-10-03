import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheshield/core/error/error_message.dart';

/// Loading spinner / error text / [builder] for an [AsyncValue]. Replaces
/// the FutureBuilder blocks the admin screens used to repeat.
class AdminAsyncBody<T> extends StatelessWidget {
  const AdminAsyncBody({super.key, required this.value, required this.builder});

  final AsyncValue<T> value;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) {
    return value.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ListView(
        padding: const EdgeInsets.all(32),
        children: [Center(child: Text(describeErrorForUser(error)))],
      ),
      data: builder,
    );
  }
}
