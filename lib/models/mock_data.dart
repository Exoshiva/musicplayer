// MARK: - Mock-Dates

// lib/models/mock_data.dart

import 'song.dart';
import 'album.dart';

final List<Song> recentlyPlayed = [

  const Song(
    id: '1',
    title: 'Love',
    artist: 'Exoshiva',
    assetPath: 'assets/audio/Love_Demo.mp3',
    imagePath: 'assets/img/Exoshiva_LOVE_Albumcover.png'
  ),
    const Song(
    id: '2',
    title: 'Flora',
    artist: 'Exoshiva',
    assetPath: 'assets/audio/Flora.wav',
    imagePath: 'assets/img/Exoshiva_FLORA_Albumcover.png'

  ),
  const Song(
    id: '3',
    title: 'Tristram Theme',
    artist: 'Matt Uelmen',
    assetPath: 'assets/audio/',
    imagePath: 'assets/img/img_1.png'
  ),
  const Song(
    id: '4',
    title: 'Merry-Go-Round',
    artist: 'Joe Hisaishi',
    assetPath: 'assets/audio/', 
    imagePath: 'assets/img/img_2.png'
  ),
];
final List<Song> recommendedForYou = [
  const Song(
    id: '5',
    title: 'Cyberpunk City',
    artist: 'Neon Drive',
    assetPath: 'assets/audio/',
    imagePath: 'assets/img/img_3.png'

  ),
  const Song(
    id: '6',
    title: 'Night City Vibes',
    artist: 'Synthwave',
    assetPath: 'assets/audio/',
    imagePath: 'assets/img/img_4.png'

  ),
  const Song(
    id: '7',
    title: 'Calisthenics Flow',
    artist: 'Workout Beats',
    assetPath: 'assets/audio/',
    imagePath: 'assets/img/img_5.png'

  ),
];

// MARK: - Mock-Dates
final Album mockAlbum = Album(
  id: 'album1',
  title: 'Mock Album',
  artist: 'Mock Artist',
  coverPath: 'assets/img/Mock_Album_Cover.png',
  songs: recentlyPlayed, // Use the recentlyPlayed list as the songs for this album
);


