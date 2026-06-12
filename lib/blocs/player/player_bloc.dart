import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/audio_repository.dart'; // Aus meinem vorherigen Post
import 'player_event.dart';
import 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final AudioRepository audioRepository;

  PlayerBloc({required this.audioRepository}) : super(PlayerInitial()) {
    
    on<PlaySong>((event, emit) async {
      // Spielt den Song über das Repository ab (nutzt jetzt assetPath aus deiner Song Klasse)
      await audioRepository.play(event.song.assetPath);
      emit(PlayerPlaying(event.song));
    });

    on<PauseSong>((event, emit) {
      audioRepository.pause();
      if (state is PlayerPlaying) {
        emit(PlayerPaused((state as PlayerPlaying).currentSong));
      }
    });
  }
}