import 'package:equatable/equatable.dart';
import '../../models/song.dart';

abstract class PlayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlayerInitial extends PlayerState {}

class PlayerPlaying extends PlayerState {
  final Song currentSong;
  PlayerPlaying(this.currentSong);

  @override
  List<Object?> get props => [currentSong];
}

class PlayerPaused extends PlayerState {
  final Song currentSong;
  PlayerPaused(this.currentSong);

  @override
  List<Object?> get props => [currentSong];
}