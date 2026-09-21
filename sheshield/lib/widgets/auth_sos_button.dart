import 'package:flutter/material.dart';
import '../models/saved_contact.dart';
import '../services/contacts_store.dart';
import '../services/sos_service.dart';
import '../theme/app_theme.dart';

/// The SOS button, wired to the real alert flow. Same look as SosButton, but
/// instead of pretending, it sends the alert and then shows exactly which
/// contacts were and were not reached.
class AuthSosButton extends StatefulWidget {
  const AuthSosButton({
    super.key,
    required this.userName,
    required this.store,
    this.size = 132,
  });

  final String userName;
  final ContactsStore store;
  final double size;

  @override
  State<AuthSosButton> createState() => _AuthSosButtonState();
}

class _AuthSosButtonState extends State<AuthSosButton> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  final _service = SosService();
  bool _opening = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _handleTap() async {
    if (_opening) return;
    final store = widget.store;

    if (store.loading && store.contacts.isEmpty) {
      _snack('Still loading your contacts. Try again in a moment.');
      return;
    }
    if (store.contacts.isEmpty) {
      _snack('Add at least one trusted contact first.');
      return;
    }

    // Ask for location/SMS permission now, so the alert itself isn't held up
    // by system dialogs.
    _opening = true;
    try {
      await _service.requestPermissions();
    } finally {
      _opening = false;
    }
    if (!mounted) return;

    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ConfirmSheet(contactCount: store.contacts.length),
    );
    if (confirmed != true || !mounted) return;

    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, _, _) => _SosResultOverlay(userName: widget.userName, store: store),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    return GestureDetector(
      onTap: _handleTap,
      child: SizedBox(
        width: size * 1.7,
        height: size * 1.7,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: List.generate(2, (i) {
                    final progress = (_pulseController.value + (i * 0.5)) % 1.0;
                    return Opacity(
                      opacity: (1 - progress) * 0.35,
                      child: Container(
                        width: size + (size * 0.7 * progress),
                        height: size + (size * 0.7 * progress),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.sosStart,
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: AppColors.sosGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.sosEnd.withValues(alpha: 0.45),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_moon_rounded, color: Colors.white, size: size * 0.30),
                  const SizedBox(height: 4),
                  Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: size * 0.18,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmSheet extends StatelessWidget {
  const _ConfirmSheet({required this.contactCount});
  final int contactCount;

  @override
  Widget build(BuildContext context) {
    final who = contactCount == 1 ? 'your trusted contact' : 'your $contactCount trusted contacts';
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: softShadow(opacity: 0.18),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: AppColors.sosGradient),
              ),
              child: const Icon(Icons.warning_rounded, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 18),
            Text(
              'Send emergency alert?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Your location and an SOS message will be texted to $who right away.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFFE3DEF5)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sosEnd,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Send SOS', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Runs the alert and shows the truth about it: sending, or exactly which
/// contacts were and weren't reached.
class _SosResultOverlay extends StatefulWidget {
  const _SosResultOverlay({required this.userName, required this.store});

  final String userName;
  final ContactsStore store;

  @override
  State<_SosResultOverlay> createState() => _SosResultOverlayState();
}

class _SosResultOverlayState extends State<_SosResultOverlay> {
  final _service = SosService();

  bool _sending = true;
  String? _fatal;
  List<ContactOutcome> _outcomes = const [];
  bool _hadLocation = true;

  @override
  void initState() {
    super.initState();
    _send(widget.store.contacts);
  }

  /// [targets] is everyone on the first attempt, and only the contacts that
  /// weren't reached on a retry (so nobody gets the same text twice).
  Future<void> _send(List<SavedContact> targets) async {
    setState(() {
      _sending = true;
      _fatal = null;
    });
    try {
      final result = await _service.trigger(userName: widget.userName, contacts: targets);
      if (!mounted) return;
      final alreadyReached = _outcomes.where((o) => o.delivered).toList();
      setState(() {
        _outcomes = [...alreadyReached, ...result.outcomes];
        _hadLocation = result.hadLocation;
        _sending = false;
      });
    } on SosException catch (e) {
      if (!mounted) return;
      setState(() {
        _fatal = e.message;
        _sending = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _fatal = 'Something went wrong while sending. Please try again.';
        _sending = false;
      });
    }
  }

  int get _deliveredCount => _outcomes.where((o) => o.delivered).length;
  bool get _allDelivered => _outcomes.isNotEmpty && _deliveredCount == _outcomes.length;
  bool get _noneDelivered => _deliveredCount == 0;

  List<SavedContact> get _notReached =>
      _outcomes.where((o) => !o.delivered).map((o) => o.contact).toList();

  String _labelFor(ContactOutcome o) {
    switch (o.delivery) {
      case Delivery.fromPhone:
        return 'Texted from your phone';
      case Delivery.byServer:
        return 'Sent by SheShield';
      case Delivery.notDelivered:
        return o.detail ?? 'Not delivered';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_sending,
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: _sending ? _buildSending() : _buildDone(),
          ),
        ),
      ),
    );
  }

  Widget _buildSending() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: CircularProgressIndicator(strokeWidth: 4, color: Colors.white),
        ),
        SizedBox(height: 24),
        Text(
          'Sending your alert…',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 8),
        Text(
          'Getting your location and texting your contacts.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildDone() {
    if (_fatal != null) {
      return _panel(
        icon: Icons.error_outline_rounded,
        color: AppColors.sosEnd,
        title: 'Alert not sent',
        subtitle: _fatal!,
        rows: const [],
        retryTargets: _outcomes.isEmpty ? widget.store.contacts : _notReached,
      );
    }

    final total = _outcomes.length;
    final IconData icon;
    final Color color;
    final String title;
    if (_allDelivered) {
      icon = Icons.check_rounded;
      color = AppColors.success;
      title = 'SOS sent';
    } else if (_noneDelivered) {
      icon = Icons.close_rounded;
      color = AppColors.sosEnd;
      title = 'Alert NOT sent';
    } else {
      icon = Icons.warning_amber_rounded;
      color = AppColors.warning;
      title = 'Sent to $_deliveredCount of $total contacts';
    }

    final notes = <String>[
      if (!_hadLocation) 'Your location was unavailable, so the message has no map link.',
      if (!_allDelivered) 'In immediate danger? Call 999.',
    ];

    return _panel(
      icon: icon,
      color: color,
      title: title,
      subtitle: notes.join('\n'),
      rows: _outcomes,
      retryTargets: _allDelivered ? const [] : _notReached,
    );
  }

  Widget _panel({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required List<ContactOutcome> rows,
    required List<SavedContact> retryTargets,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 600),
          curve: Curves.elasticOut,
          builder: (context, value, child) => Transform.scale(scale: value, child: child),
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, color: Colors.white, size: 48),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800),
        ),
        if (subtitle.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 13.5, height: 1.4),
          ),
        ],
        if (rows.isNotEmpty) ...[
          const SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [for (final o in rows) _row(o)],
              ),
            ),
          ),
        ],
        const SizedBox(height: 24),
        if (retryTargets.isNotEmpty) ...[
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.sosEnd,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: () => _send(retryTargets),
              child: const Text('Try again', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(height: 10),
        ],
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.sosEnd,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ),
      ],
    );
  }

  Widget _row(ContactOutcome o) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            o.delivered ? Icons.check_circle_rounded : Icons.error_rounded,
            color: o.delivered ? AppColors.success : AppColors.sosStart,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  o.contact.name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  _labelFor(o),
                  style: const TextStyle(color: Colors.white70, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
