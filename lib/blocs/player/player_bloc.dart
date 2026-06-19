import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/audio_repository.dart'; 
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioRepository audioRepository;

  PlayerBloc({required this.audioRepository}) : super(PlayerInitial()) {
    
    on<PlaySong>((event, emit) async {
      // Spielt den Song über das Repository ab (nutzt assetPath aus der Song Klasse)
      await audioRepository.play(event.song.assetPath);
      emit(PlayerPlaying(event.song));
    });

    on<PauseSong>((event, emit) {
      audioRepository.pause();
      if (state is PlayerPlaying) {
        emit(PlayerPaused((state as PlayerPlaying).currentSong));
      }

    on<ResumeSong>((event, emit) async {
      if (state is PlayerPaused){
        final currentSong = (state as PlayerPaused).currentSong;
        audioRepository.resume();
        emit(PlayerPlaying(currentSong));
        }
      });
    });
  }
}