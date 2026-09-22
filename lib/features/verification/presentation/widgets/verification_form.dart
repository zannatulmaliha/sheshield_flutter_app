import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheshield/core/theme/app_theme.dart';
import '../../domain/entities/verification_status.dart';
import 'photo_picker_tile.dart';

/// The upload form, shown when status is none or rejected. Owns its own
/// in-progress photo state; only calls [onSubmit] once all three are picked.
class VerificationForm extends StatefulWidget {
  const VerificationForm({super.key, required this.status, required this.onSubmit});

  final VerificationStatus status;
  final Future<String?> Function({
    required Uint8List nidFront,
    required Uint8List nidBack,
    required Uint8List selfie,
  }) onSubmit;

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  static const _maxBytes = 5 * 1024 * 1024; // matches the server's 5 MB limit
  final _picker = ImagePicker();

  Uint8List? _front, _back, _selfie;
  String? _error;
  bool _submitting = false;

  Future<void> _pick(bool selfie, void Function(Uint8List) set) async {
    final file = await _picker.pickImage(
      source: selfie ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1600,
      preferredCameraDevice: CameraDevice.front,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (bytes.length > _maxBytes) {
      setState(() => _error = 'That photo is too large (5 MB max).');
      return;
    }
    setState(() {
      set(bytes);
      _error = null;
    });
  }

  Future<void> _submit() async {
    final front = _front, back = _back, selfie = _selfie;
    if (front == null || back == null || selfie == null) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    final error = await widget.onSubmit(nidFront: front, nidBack: back, selfie: selfie);
    if (!mounted) return;
    setState(() {
      _submitting = false;
      _error = error;
      if (error == null) _front = _back = _selfie = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ready = _front != null && _back != null && _selfie != null;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        if (widget.status.status == VerificationState.rejected && widget.status.note.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.sosEnd.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text('Not approved: ${widget.status.note}\nYou can send new photos below.',
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
          ),
        const Text('Verify your identity',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        const Text(
          'Add a photo of the front and back of your national ID, and a selfie so we can compare your face to it.',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13.5, height: 1.45),
        ),
        const SizedBox(height: 20),
        PhotoPickerTile(
          label: 'ID card: front',
          hint: 'All corners visible, text readable',
          icon: Icons.badge_outlined,
          bytes: _front,
          onTap: _submitting ? null : () => _pick(false, (b) => setState(() => _front = b)),
        ),
        PhotoPickerTile(
          label: 'ID card: back',
          hint: 'Flat, in good light, no glare',
          icon: Icons.credit_card_rounded,
          bytes: _back,
          onTap: _submitting ? null : () => _pick(false, (b) => setState(() => _back = b)),
        ),
        PhotoPickerTile(
          label: 'Selfie',
          hint: 'Your face, clearly visible, taken now',
          icon: Icons.face_rounded,
          bytes: _selfie,
          onTap: _submitting ? null : () => _pick(true, (b) => setState(() => _selfie = b)),
        ),
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10),
            child: Text(_error!, style: const TextStyle(color: AppColors.sosEnd, fontWeight: FontWeight.w700, fontSize: 12.5)),
          ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: (ready && !_submitting) ? _submit : null,
          child: _submitting
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white))
              : const Text('Submit for review', style: TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}