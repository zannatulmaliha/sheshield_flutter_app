import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/verification_info.dart';
import '../services/auth_controller.dart';
import '../services/verification_service.dart';
import '../theme/app_theme.dart';

enum _Slot { nidFront, nidBack, selfie }

/// Helpers are checked by a person before they can respond to alerts, because
/// a helper can see where someone in danger is. This screen collects the
/// photos; the decision is made on the server, never on the phone.
class HelperVerificationScreen extends StatefulWidget {
  const HelperVerificationScreen({super.key, required this.controller});

  final AuthController controller;

  @override
  State<HelperVerificationScreen> createState() => _HelperVerificationScreenState();
}

class _HelperVerificationScreenState extends State<HelperVerificationScreen> {
  static const _maxPhotoBytes = 5 * 1024 * 1024; // must match the server's limit

  final _service = VerificationService();
  final _picker = ImagePicker();

  VerificationInfo? _info;
  bool _loading = true;
  String? _loadError;

  Uint8List? _front;
  Uint8List? _back;
  Uint8List? _selfie;
  bool _submitting = false;
  String? _submitError;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onAuthChanged);
    _load();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onAuthChanged);
    super.dispose();
  }

  /// This screen is pushed on top of the app. If the login expires the app
  /// swaps to the login screen underneath, so this route must go away too.
  void _onAuthChanged() {
    if (!mounted) return;
    if (widget.controller.status != AuthStatus.signedIn) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  Future<void> _load() async {
    try {
      final info = await _service.status();
      if (!mounted) return;
      setState(() {
        _info = info;
        _loadError = null;
        _loading = false;
      });
      // Approved on the server: pick up the new "verified" flag for the app.
      if (info.state == VerificationState.approved) {
        await widget.controller.refreshUser();
      }
    } on VerificationException catch (e) {
      if (e.unauthorized) {
        await widget.controller.logout();
        return;
      }
      if (!mounted) return;
      setState(() {
        _loadError = e.message;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loadError = 'Something went wrong. Please try again.';
        _loading = false;
      });
    }
  }

  Future<void> _pick(_Slot slot) async {
    var source = ImageSource.camera;
    if (slot != _Slot.selfie) {
      // An ID can come from the gallery; a selfie must be taken now.
      final choice = await showModalBottomSheet<ImageSource>(
        context: context,
        backgroundColor: AppColors.background,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (ctx) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera_rounded),
                title: const Text('Take a photo'),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: const Text('Choose from gallery'),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
            ],
          ),
        ),
      );
      if (choice == null) return;
      source = choice;
    }

    try {
      final file = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
        maxHeight: 1600,
        preferredCameraDevice: slot == _Slot.selfie ? CameraDevice.front : CameraDevice.rear,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      if (bytes.length > _maxPhotoBytes) {
        setState(() => _submitError = 'That photo is too large (5 MB max). Please try another.');
        return;
      }
      setState(() {
        switch (slot) {
          case _Slot.nidFront:
            _front = bytes;
          case _Slot.nidBack:
            _back = bytes;
          case _Slot.selfie:
            _selfie = bytes;
        }
        _submitError = null;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _submitError = "Couldn't open the camera or gallery. Check the app's permissions and try again.");
    }
  }

  Future<void> _submit() async {
    final front = _front;
    final back = _back;
    final selfie = _selfie;
    if (front == null || back == null || selfie == null) return;

    setState(() {
      _submitting = true;
      _submitError = null;
    });
    try {
      final info = await _service.submit(nidFront: front, nidBack: back, selfie: selfie);
      if (!mounted) return;
      setState(() {
        _info = info;
        _front = null;
        _back = null;
        _selfie = null;
        _submitting = false;
      });
    } on VerificationException catch (e) {
      if (e.unauthorized) {
        await widget.controller.logout();
        return;
      }
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _submitError = e.message;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _submitting = false;
        _submitError = 'Something went wrong. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Helper verification'),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [_content()],
        ),
      ),
    );
  }

  Widget _content() {
    if (_loading) {
      return const Padding(
        padding: EdgeInsets.only(top: 100),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_loadError != null) {
      return _StatusPanel(
        icon: Icons.cloud_off_rounded,
        color: AppColors.textSecondary,
        title: "Couldn't load your status",
        message: _loadError!,
        buttonLabel: 'Try again',
        onButton: () {
          setState(() {
            _loading = true;
            _loadError = null;
          });
          _load();
        },
      );
    }

    final info = _info!;
    switch (info.state) {
      case VerificationState.approved:
        return _StatusPanel(
          icon: Icons.verified_rounded,
          color: AppColors.success,
          title: "You're verified",
          message: 'You can respond to alerts from people who need help. Thank you for helping keep others safe.',
          buttonLabel: 'Done',
          onButton: () => Navigator.of(context).pop(),
        );
      case VerificationState.pending:
        return _StatusPanel(
          icon: Icons.hourglass_top_rounded,
          color: AppColors.warning,
          title: 'Under review',
          message: 'A reviewer is checking your documents. This can take a while. '
              "You'll be able to respond to alerts once you're approved.\n\nPull down to check for an update.",
          buttonLabel: 'Check status',
          onButton: _load,
        );
      case VerificationState.none:
      case VerificationState.rejected:
        return _form(info);
    }
  }

  Widget _form(VerificationInfo info) {
    final ready = _front != null && _back != null && _selfie != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (info.state == VerificationState.rejected) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.sosEnd.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.sosEnd.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your last request was not approved',
                  style: TextStyle(color: AppColors.sosEnd, fontWeight: FontWeight.w800, fontSize: 14),
                ),
                if (info.note.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    info.note,
                    style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, height: 1.4),
                  ),
                ],
                const SizedBox(height: 6),
                const Text(
                  'You can send new photos below.',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
        ],
        const Text(
          'Verify your identity',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        const Text(
          'Helpers can see where someone in danger is, so a person checks every helper first. '
          'Add a photo of the front and back of your national ID, and a selfie so we can compare your face to it.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13.5, height: 1.45, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        _PhotoTile(
          label: 'ID card: front',
          hint: 'All four corners visible, text readable',
          icon: Icons.badge_outlined,
          bytes: _front,
          onTap: _submitting ? null : () => _pick(_Slot.nidFront),
        ),
        const SizedBox(height: 12),
        _PhotoTile(
          label: 'ID card: back',
          hint: 'Flat, in good light, no glare',
          icon: Icons.credit_card_rounded,
          bytes: _back,
          onTap: _submitting ? null : () => _pick(_Slot.nidBack),
        ),
        const SizedBox(height: 12),
        _PhotoTile(
          label: 'Selfie',
          hint: 'Your face, clearly visible, taken now',
          icon: Icons.face_rounded,
          bytes: _selfie,
          onTap: _submitting ? null : () => _pick(_Slot.selfie),
        ),
        const SizedBox(height: 16),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lock_outline_rounded, size: 16, color: AppColors.textSecondary),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Only the SheShield reviewer can see these photos. They are never shown to other users.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
        if (_submitError != null) ...[
          const SizedBox(height: 14),
          Text(
            _submitError!,
            style: const TextStyle(color: AppColors.sosEnd, fontWeight: FontWeight.w700, fontSize: 12.5),
          ),
        ],
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: (ready && !_submitting) ? _submit : null,
          child: _submitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                )
              : const Text('Submit for review', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.label,
    required this.hint,
    required this.icon,
    required this.bytes,
    required this.onTap,
  });

  final String label;
  final String hint;
  final IconData icon;
  final Uint8List? bytes;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final picked = bytes != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: picked ? AppColors.success : const Color(0xFFE3DEF5),
            width: picked ? 2 : 1.5,
          ),
        ),
        child: picked
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.memory(bytes!, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$label · tap to change',
                        style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 34, color: AppColors.primary),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    hint,
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                ],
              ),
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onButton,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48),
      child: Column(
        children: [
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color.withValues(alpha: 0.14)),
            child: Icon(icon, size: 44, color: color),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 21, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 10),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5, height: 1.5, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          OutlinedButton(onPressed: onButton, child: Text(buttonLabel)),
        ],
      ),
    );
  }
}
