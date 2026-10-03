
import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheshield/features/verification/presentation/widgets/verification_photo_slot.dart';

/// Matches the server's 5 MB limit per photo.
const _maxPhotoBytes = 5 * 1024 * 1024;

@immutable
class VerificationPhotos {
  const VerificationPhotos({
    required this.photos,
    required this.errorMessage,
    required this.pick,
    required this.clear,
  });

  final Map<VerificationPhotoSlot, Uint8List> photos;
  final String? errorMessage;
  final Future<void> Function(VerificationPhotoSlot slot) pick;
  final VoidCallback clear;

  Uint8List? operator [](VerificationPhotoSlot slot) => photos[slot];

  bool get isComplete => photos.length == VerificationPhotoSlot.values.length;
}

/// Holds the picked verification photos and the picker's own error (such as
/// "too large"). Replaces the form's `setState` photo fields.
VerificationPhotos useVerificationPhotos() {
  final picker = useMemoized(ImagePicker.new);
  final photos = useState(const <VerificationPhotoSlot, Uint8List>{});
  final errorMessage = useState<String?>(null);
  final isMounted = useIsMounted();

  Future<void> pick(VerificationPhotoSlot slot) async {
    final file = await picker.pickImage(
      source: slot.source,
      imageQuality: 85,
      maxWidth: 1600,
      preferredCameraDevice: CameraDevice.front,
    );
    if (file == null) return;

    final bytes = await file.readAsBytes();
    if (!isMounted()) return;
    if (bytes.length > _maxPhotoBytes) {
      errorMessage.value = 'That photo is too large (5 MB max).';
      return;
    }
    photos.value = {...photos.value, slot: bytes};
    errorMessage.value = null;
  }

  return VerificationPhotos(
    photos: photos.value,
    errorMessage: errorMessage.value,
    pick: pick,
    clear: () => photos.value = const {},
  );
}
