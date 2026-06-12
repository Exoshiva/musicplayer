import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // BLoC Import
import 'package:musicplayer/models/mock_data.dart';
import 'package:musicplayer/models/song.dart';
// Deine BLoC Imports
import '../blocs/player/player_bloc.dart';
import '../blocs/player/player_event.dart';
import '../blocs/player/player_state.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // local copy list for drag and drop
  late List<Song> queue;
  
  @override 
  void initState() {
    super.initState();
    queue = List.from(recentlyPlayed);
  }

  @override
  Widget build(BuildContext context) {
    // 1. Den gesamten Body in einen BlocBuilder wickeln, damit Texte UND Buttons dynamisch sind
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        
        // Dynamische Werte abgreifen
        String displayTitle = 'Nichts wird abgespielt';
        String displayArtist = '-';
        bool isPlaying = state is PlayerPlaying;

        if (state is PlayerPlaying) {
          displayTitle = state.currentSong.title;
          displayArtist = state.currentSong.artist;
        } else if (state is PlayerPaused) {
          displayTitle = state.currentSong.title;
          displayArtist = state.currentSong.artist;
        }

        return Scaffold(
          // Transparent AppBar
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // <-Back-Button
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
              onPressed: () {
                Navigator.pop(context); // close the screen and turn back to home-screen
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                // 1. Album-Cover (Base for Cover-Animations)
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFA400E0),
                          Color(0xFF3EFFF5),
                        ],
                        begin: AlignmentGeometry.topLeft,
                        end: AlignmentGeometry.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3EFFF5).withValues(alpha: 0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // 2. Song-Informations and Favorite-Star
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayTitle, // <-- DYNAMISCHER TITEL
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            displayArtist, // <-- DYNAMISCHER ARTIST
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white54
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.star_border, size: 28, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // 3. Progress-Bar / timeline (Material 3 Slider)
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                    activeTrackColor: Colors.white24,
                    thumbColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Slider(value: 0.3, onChanged: (value) {}),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1:04', style: TextStyle(color: Colors.white54, fontSize: 12)),
                      Text('-2:30', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // MARK: 4. Playback-Controlls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shuffle, color: Colors.white54),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_previous, size: 40, color: Colors.white),
                      onPressed: () {},
                    ),
                    
                    // The Big Play-Button (Center)
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        // Icon wechselt zwischen Play und Pause
                        icon: Icon(
                          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, 
                          color: Colors.black, 
                          size: 48
                        ),
                        onPressed: () {
                          // Echte Audio-Steuerung
                          if (isPlaying) {
                            context.read<PlayerBloc>().add(PauseSong());
                          } else if (state is PlayerPaused) {
                            // Spielt den aktuellen Song weiter
                            context.read<PlayerBloc>().add(PlaySong(state.currentSong));
                          }
                        },
                      ),
                    ),
                    
                    IconButton(
                      icon: const Icon(Icons.skip_next, size: 40, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.repeat, size: 24, color: Colors.white54),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // 5. Queue-Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.queue_music_rounded, color: Colors.white, size: 28),
                      onPressed: () => _showQueueBottomSheet(context),
                    ),
                  ],
                ),
              ],
            )
          ),
        );
      }
    );
  }

  // MARK: - Bottom Sheet für die Warteschlange
  void _showQueueBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.transparent, 
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6, 
              color: const Color(0xFF0B192C).withValues(alpha: 0.8), 
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white38, borderRadius: BorderRadius.circular(2))),
                  ),
                  const SizedBox(height: 24),
                  const Text('Als Nächstes', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  
                  Expanded(
                    child: StatefulBuilder( 
                      builder: (BuildContext context, StateSetter setModalState) {
                        return ReorderableListView.builder(
                          itemCount: queue.length,
                          onReorder: (oldIndex, newIndex) {
                            setModalState(() {
                              if (newIndex > oldIndex) newIndex -= 1;
                              final Song item = queue.removeAt(oldIndex);
                              queue.insert(newIndex, item);
                            });
                          },
                          proxyDecorator: (child, index, animation) => Material(color: Colors.transparent, child: child),
                          itemBuilder: (context, index) {
                            final song = queue[index];
                            return ListTile(
                              key: ValueKey(song.title), 
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(width: 48, height: 48, color: Colors.white10, child: const Icon(Icons.music_note, color: Colors.white38)),
                              ),
                              title: Text(song.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              subtitle: Text(song.artist, style: const TextStyle(color: Colors.white54)),
                              trailing: const Icon(Icons.drag_handle_rounded, color: Colors.white38),
                            );
                          },
                        );
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}