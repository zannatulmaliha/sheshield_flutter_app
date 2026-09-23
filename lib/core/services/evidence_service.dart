import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Thin wrapper so nothing above core/ imports image_picker/path_provider
/// directly. Captures a photo or video from the device camera and copies
/// it into the app's own documents directory under evidence/, named with
/// a timestamp, so it survives independently of wherever the OS camera
/// app happened to write its temp file.
class EvidenceService {
  final _picker = ImagePicker();

  Future<String?> capturePhoto() => _capture(video: false);
  Future<String?> captureVideo() => _capture(video: true);

  Future<String?> _capture({required bool video}) async {
    final XFile? file = video
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.camera, imageQuality: 90);
    if (file == null) return null;

    final dir = await getApplicationDocumentsDirectory();
    final evidenceDir = Directory('${dir.path}/evidence');
    if (!await evidenceDir.exists()) {
      await evidenceDir.create(recursive: true);
    }
    final ext = video ? 'mp4' : 'jpg';
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final savedPath = '${evidenceDir.path}/evidence_$timestamp.$ext';
    await File(file.path).copy(savedPath);
    return savedPath;
  }
}
