import 'package:equatable/equatable.dart';
import '../../models/song.dart'; // Nutzt jetzt die Song-Klasse

abstract class PlayerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaySong extends PlayerEvent {
  final Song song;
  PlaySong(this.song);

  @override
  List<Object> get props => [song];
}

class PauseSong extends PlayerEvent {}