import 'package:just_audio/just_audio.dart';

class AudioRepository {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> play(String assetPath) async {
    // Stoppt aktuellen Song, lädt den neuen und spielt ihn ab
    await _audioPlayer.stop();
    await _audioPlayer.setAsset(assetPath);
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

  void stop() {
    _audioPlayer.stop();
  }
}