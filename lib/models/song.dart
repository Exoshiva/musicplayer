import 'package:equatable/equatable.dart';
class Song extends Equatable {
  final String id;
  final String title;
  final String artist;
  final String assetPath;
  final String imagePath;


  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.assetPath,
    required this.imagePath,

  });

  @override
  List<Object?> get props => [id, title, artist, assetPath, imagePath];
}
