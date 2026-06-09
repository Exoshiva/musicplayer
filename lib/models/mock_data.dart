// MARK: - Mock-Dates

// lib/models/mock_data.dart

import 'song.dart';

final List<Song> recentlyPlayed = [
  const Song(
    id: '1',
    title: 'Specialz',
    artist: 'King Gnu',
    gradientColors: ['FF8E2DE2', 'FF4A00E0'], // Violett zu dunklem Lila
  ),
  const Song(
    id: '2',
    title: 'Gurenge',
    artist: 'LiSA',
    gradientColors: ['FFFF416C', 'FFFF4B2B'], // Sattes Rot-Orange
  ),
  const Song(
    id: '3',
    title: 'Tristram Theme',
    artist: 'Matt Uelmen',
    gradientColors: ['FF434343', 'FF000000'], // Dunkles Grau/Schwarz
  ),
  const Song(
    id: '4',
    title: 'Merry-Go-Round',
    artist: 'Joe Hisaishi',
    gradientColors: ['FF11998E', 'FF38EF7D'], // Sanftes Grün
  ),
];
final List<Song> recommendedForYou = [
  const Song(
    id: '5',
    title: 'Cyberpunk City',
    artist: 'Neon Drive',
    gradientColors: ['FF8E2D2E', 'FF4A00E0'],
    //coverColorHex: 'FF00B8D4', // Cyan
  ),
  const Song(
    id: '6',
    title: 'Night City Vibes',
    artist: 'Synthwave',
    gradientColors: ['FF8E2D2E', 'FF4A00E0'],
    //coverColorHex: 'FFD50000', // Deep Red
  ),
  const Song(
    id: '7',
    title: 'Calisthenics Flow',
    artist: 'Workout Beats',
    gradientColors: ['FF8E2D2E', 'FF4A00E0'],
    //coverColorHex: 'FFFF8F00', // Amber
  ),
];