import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class RecordService {
  final AudioRecorder _recorder = AudioRecorder();

  Future<bool> hasPermission() async {
    return await _recorder.hasPermission();
  }

  Future<void> startRecording() async {
    if (!await hasPermission()) {
      throw Exception("Permission not granted");
    }

    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(
      RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );
  }

  Future<String?> stopRecording() async {
    if (await _recorder.isRecording()) {
      return await _recorder.stop();
    }
    return null;
  }

  Future<void> cancelRecording() async {
    if (await _recorder.isRecording()) {
      await _recorder.stop();
    }
  }

  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }
}
