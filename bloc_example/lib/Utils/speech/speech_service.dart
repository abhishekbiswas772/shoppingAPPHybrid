import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;

  Future<void> initSpeechServiceAndRecognize(Function(String?) callBack) async {
    try {
      _speechEnabled = await _speechToText.initialize();
      if (_speechEnabled) {
        await _speechToText.listen(
          onResult: (result) {
            String finalRecogString = result.recognizedWords.toString();
            callBack(finalRecogString);
          },
        );
      } else {
        callBack(null);
      }
    } catch (_) {
      return;
    }
  }

  Future<void> stopSpeechService() async {
    try {
      await _speechToText.stop();
    } catch (_) {
      return;
    }
  }
}
