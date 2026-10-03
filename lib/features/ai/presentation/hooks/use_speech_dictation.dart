import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

@immutable
class SpeechDictation {
  const SpeechDictation({required this.isListening, required this.toggle});

  final bool isListening;
  final Future<void> Function() toggle;
}

/// Dictates into [textController] for the person to review. It never sends
/// automatically, so a misheard word can be fixed first. [onProblem] gets a
/// message when permission or recognition is unavailable.
SpeechDictation useSpeechDictation({
  required TextEditingController textController,
  required void Function(String message) onProblem,
}) {
  final speech = useMemoized(SpeechToText.new);
  final isListening = useState(false);
  final isMounted = useIsMounted();

  useEffect(() => () => speech.stop(), const []);

  void showRecognizedWords(SpeechRecognitionResult result) {
    textController.value = TextEditingValue(
      text: result.recognizedWords,
      selection: TextSelection.collapsed(offset: result.recognizedWords.length),
    );
  }

  Future<void> toggle() async {
    if (isListening.value) {
      await speech.stop();
      if (isMounted()) isListening.value = false;
      return;
    }

    final microphonePermission = await Permission.microphone.request();
    if (!microphonePermission.isGranted) {
      onProblem('Microphone permission is needed for voice input.');
      return;
    }

    final isAvailable = await speech.initialize(
      onStatus: (status) {
        final hasStopped = status == 'done' || status == 'notListening';
        if (hasStopped && isMounted()) isListening.value = false;
      },
    );
    if (!isAvailable) {
      onProblem('Speech recognition is not available on this device.');
      return;
    }

    isListening.value = true;
    await speech.listen(
      onResult: showRecognizedWords,
      listenOptions: SpeechListenOptions(partialResults: true),
    );
  }

  return SpeechDictation(isListening: isListening.value, toggle: toggle);
}
