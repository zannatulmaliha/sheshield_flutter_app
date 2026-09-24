import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sheshield/core/di/injection.dart';
import 'package:sheshield/core/theme/app_palette.dart';
import 'package:sheshield/features/admin/domain/entities/admin_verification.dart';
import 'package:sheshield/features/admin/domain/repositories/i_admin_repository.dart';

class AdminVerificationScreen extends ConsumerStatefulWidget {
  const AdminVerificationScreen({super.key});

  @override
  ConsumerState<AdminVerificationScreen> createState() =>
      _AdminVerificationScreenState();
}

class _AdminVerificationScreenState
    extends ConsumerState<AdminVerificationScreen> {
  late Future<List<AdminVerification>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<List<AdminVerification>> _load() =>
      getIt<IAdminRepository>().getVerificationQueue(forceRefresh: true);

  Future<void> _refresh() async {
    setState(() => _future = _load());
    await _future;
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Helper Verification'),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder<List<AdminVerification>>(
          future: _future,
          builder: (context, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Text('${snapshot.error}'),
                    ),
                  ),
                ],
              );
            }

            final items = snapshot.data!;

            if (items.isEmpty) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 120),
                    child: Center(
                      child: Text(
                        'No helper verification submissions.',
                        style: TextStyle(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) => _VerificationTile(
                item: items[i],
                colors: colors,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VerificationTile extends StatelessWidget {
  const _VerificationTile({
    required this.item,
    required this.colors,
  });

  final AdminVerification item;
  final AppPalette colors;

  @override
  Widget build(BuildContext context) {
    final pending = item.status == 'pending';

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          child: Icon(
            pending ? Icons.hourglass_top_rounded : Icons.verified_user_rounded,
          ),
        ),
        title: Text(
          item.userName.isEmpty ? item.userUid : item.userName,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${item.userEmail}\n'
            '${item.userPhone}\n'
            'Submitted ${DateFormat.yMMMd().add_jm().format(item.createdAt.toLocal())}',
          ),
        ),
        trailing: Chip(
          label: Text(item.status.toUpperCase()),
        ),
        onTap: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AdminVerificationDetailScreen(
                verificationId: item.id,
              ),
            ),
          );
        },
      ),
    );
  }
}

class AdminVerificationDetailScreen extends ConsumerStatefulWidget {
  const AdminVerificationDetailScreen({
    super.key,
    required this.verificationId,
  });

  final String verificationId;

  @override
  ConsumerState<AdminVerificationDetailScreen> createState() =>
      _AdminVerificationDetailScreenState();
}

class _AdminVerificationDetailScreenState
    extends ConsumerState<AdminVerificationDetailScreen> {
  late Future<AdminVerification> _future;
  bool _busy = false;

  @override
  void initState() {
    super.initState();

    _future = getIt<IAdminRepository>().getVerificationDetail(
      widget.verificationId,
    );
  }

  Future<void> _decide(bool approved) async {
    String note = '';

    if (!approved) {
      final controller = TextEditingController();

      note = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Reject verification'),
              content: TextField(
                controller: controller,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Reason',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(
                    context,
                    controller.text.trim(),
                  ),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ) ??
          '';

      controller.dispose();

      if (note.isEmpty) {
        return;
      }
    } else {
      final ok = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Approve helper?'),
              content: const Text(
                'This marks the helper as identity-verified and allows '
                'helper functionality.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Approve'),
                ),
              ],
            ),
          ) ??
          false;

      if (!ok) {
        return;
      }
    }

    setState(() => _busy = true);

    try {
      await getIt<IAdminRepository>().decideVerification(
        verificationId: widget.verificationId,
        approved: approved,
        note: note,
      );

      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = resolvePalette(context, ref);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Verification Review'),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: FutureBuilder<AdminVerification>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData && !snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          final v = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
            children: [
              _infoCard(colors, v),
              const SizedBox(height: 16),
              const Text(
                'NID front',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              _image(v.id, 'front'),
              const SizedBox(height: 16),
              const Text(
                'NID back',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              _image(v.id, 'back'),
              const SizedBox(height: 16),
              const Text(
                'Selfie',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              _image(v.id, 'selfie'),
              if (v.note.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Review note: ${v.note}',
                  ),
                ),
              if (v.status == 'pending') ...[
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _busy ? null : () => _decide(false),
                        icon: const Icon(Icons.close),
                        label: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: _busy ? null : () => _decide(true),
                        icon: const Icon(Icons.check),
                        label: const Text('Approve'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _image(String id, String kind) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<List<int>>(
        future: getIt<IAdminRepository>().getVerificationImage(
          verificationId: id,
          kind: kind,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              height: 180,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.data!.isEmpty) {
            return const SizedBox(
              height: 80,
              child: Center(
                child: Text('Image unavailable'),
              ),
            );
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.memory(
              Uint8List.fromList(snapshot.data!),
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }

  Widget _infoCard(
    AppPalette colors,
    AdminVerification v,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              v.userName.isEmpty ? v.userUid : v.userName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text('Email: ${v.userEmail}'),
            Text('Phone: ${v.userPhone}'),
            Text('Account type: ${v.userType}'),
            Text('Status: ${v.status.toUpperCase()}'),
            Text(
              'Submitted: '
              '${DateFormat.yMMMd().add_jm().format(v.createdAt.toLocal())}',
            ),
          ],
        ),
      ),
    );
  }
}
