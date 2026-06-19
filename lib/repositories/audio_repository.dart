import 'package:just_audio/just_audio.dart';

class AudioRepository {
  final AudioPlayer _audioPlayer = AudioPlayer();

  String? _currentAsset;

  Future<void> play(String assetPath) async {
   
     try {     
     if (_currentAsset != assetPath){
      // Stoppt aktuellen Song, lädt den neuen und spielt ihn ab
      await _audioPlayer.stop();
      await _audioPlayer.setAsset(assetPath);
      _currentAsset = assetPath;
     }
      _audioPlayer.play();
    } catch (e) {
        print("FEHLER: Konnte die Datei nicht laden: $assetPath");
        print("Details: $e");
      }
    }
    
    void pause() {
      _audioPlayer.pause();
    }

    void stop() {
      _audioPlayer.stop();
    }

    void resume() {
      try {
      _audioPlayer.play().catchError((error) {
        print("AUDIO-FEHLER BEI RESUME: $error");
      });
    } catch(e) {
      print("KRITISCHER FEHLER BEI RESUME: $e");
    }
  }

  // Provide streams for the UI (slider) 
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Future<void> seek(Duration position) => _audioPlayer.seek(position);
}