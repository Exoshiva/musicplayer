import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/player_screen.dart'; 
import '../blocs/player/player_bloc.dart';
import '../blocs/player/player_event.dart';
import '../blocs/player/player_state.dart';
import '../models/mock_data.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    // MARK: - BloC Builder
    // Der BlocBuilder sorgt dafür, dass sich das UI ändert, wenn Musik startet!
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {

         String? displayImagePath;

        // 1. Standard-Werte fest (falls gerade kein Song läuft)
        String displayTitle = 'Title';
        String displayArtist = 'Artist';
        bool isPlaying = state is PlayerPlaying;

        // 2. 
        if (state is PlayerPlaying) {
          displayTitle = state.currentSong.title;
          displayArtist = state.currentSong.artist;
          displayImagePath = state.currentSong.imagePath;
        } else if (state is PlayerPaused) {
          displayTitle = state.currentSong.title;
          displayArtist = state.currentSong.artist;
          displayImagePath = state.currentSong.imagePath;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          // 1. ClipRRect hält den Blur in den runden Ecken
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            // 2. Der Milchglas-Weichzeichner
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              // 3. Der Container mit hellen, extrem transparenter Farbe
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ), // Das ist dein heller Glas-Effekt!
                  borderRadius: BorderRadius.circular(12),
                  // Ein hauchdünner weißer Rand 
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                    width: 1.5,
                  ),
                ),
                // 1. ClipRRect sorgt dafür, dass der Klick-Effekt nicht über die runden Ecken hinausragt
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  // 2. Material ist nötig, damit das InkWell seinen Ripple-Effekt zeichnen kann
                  child: Material(
                    color: Colors.transparent,
                    // 3. InkWell macht das Widget klickbar
                    child: InkWell(
                      onTap: () {
                        // 4. Die fließende Slide-Animation zum Vollbild-Player
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => const PlayerScreen(),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0); // Startet am unteren Bildschirmrand
                              const end = Offset.zero; // Endet exakt an der normalen Position
                              const curve = Curves.easeOutQuart; // Eine sehr weiche,Kurve

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              // MARK: - MiniPlayer-Cover
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: Colors.white10, // Fallback color
                                  borderRadius: BorderRadius.circular(12),
                                  image: displayImagePath != null
                                  ? DecorationImage(image: AssetImage(displayImagePath),
                                  fit: BoxFit.cover
                                  )
                                : null,
                                ),
                                // Fallback No Image (Note-Icon)
                                child: displayImagePath == null
                                  ? const Icon(Icons.music_note, color: Colors.white38)
                                  : null,
                              ),

                            const SizedBox(width: 12),
                            
                            // 2. Info (Titel & Artist)
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayTitle, // <-- TITEL AUS DEM BLOC
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    displayArtist, // <-- ARTIST AUS DEM BLOC
                                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            // 3. Controls
                            IconButton(
                              icon: const Icon(Icons.skip_previous_rounded),
                              onPressed: () {
                                context.read<PlayerBloc>().add(SkipPrevious());
                              },
                            ),
                            IconButton(
                              // Icon ändert sich automatisch zwischen Play und Pause
                              icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 32),
                              onPressed: () {
                                // MARK: - Audio-Steuerung
                                if (isPlaying) {
                                  context.read<PlayerBloc>().add(PauseSong());
                                } else if (state is PlayerPaused) {
                                  context.read<PlayerBloc>().add(ResumeSong());
                                } else if (state is PlayerInitial) {
                                  context.read<PlayerBloc>().add(PlaySong(recentlyPlayed[0]));
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next_rounded),
                              onPressed: () {
                                context.read<PlayerBloc>().add(SkipNext());
                              },
                              
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}