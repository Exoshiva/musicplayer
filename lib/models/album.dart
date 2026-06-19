// MARK: - Album Model
// lib/models/album.dart

import 'package:equatable/equatable.dart';

import 'song.dart';

class Album extends Equatable{
  final String id;
  final String title;
  final String artist;
  final String coverPath;
  final List<Song> songs;

  const Album({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverPath,
    required this.songs,
  });
  
  @override
  List<Object?> get props => [id, title, artist, coverPath, songs];
}