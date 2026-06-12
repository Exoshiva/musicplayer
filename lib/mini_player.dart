import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // WICHTIG!
import '../screens/player_screen.dart'; // WICHTIG: Den Player-Screen importieren
import '../blocs/player/player_bloc.dart';
import '../blocs/player/player_event.dart';
import '../blocs/player/player_state.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    // Der BlocBuilder sorgt dafür, dass sich das UI ändert, wenn Musik startet!
    return BlocBuilder<PlayerBloc, PlayerState>(
      builder: (context, state) {
        
        // 1. Wir legen Standard-Werte fest (falls gerade kein Song läuft)
        String displayTitle = 'Nichts wird abgespielt';
        String displayArtist = '-';
        bool isPlaying = state is PlayerPlaying;

        // 2. Wenn der State sagt "Es spielt was" oder "Pausiert", holen wir die echten Daten!
        if (state is PlayerPlaying) {
          displayTitle = state.currentSong.title;
          displayArtist = state.currentSong.artist;
        } else if (state is PlayerPaused) {
          displayTitle = state.currentSong.title;
          displayArtist = state.currentSong.artist;
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          // 1. ClipRRect sorgt dafür, dass der Klick-Effekt nicht über die runden Ecken hinausragt
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
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
                        const curve = Curves.easeOutQuart; // Eine sehr weiche, abbremsende Kurve

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Row(
                  children: [
                    // 1. Little Cover
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // 2. Info (Titel & Artist)
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayTitle, // <-- ECHTER TITEL AUS DEM BLOC
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            displayArtist, // <-- ECHTER ARTIST AUS DEM BLOC
                            style: const TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    
                    // 3. Controls
                    IconButton(
                      icon: const Icon(Icons.skip_previous_rounded),
                      onPressed: () {},
                    ),
                    IconButton(
                      // Icon ändert sich automatisch zwischen Play und Pause
                      icon: Icon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 32),
                      onPressed: () {
                        // HIER: Echte Audio-Steuerung!
                        if (isPlaying) {
                          context.read<PlayerBloc>().add(PauseSong());
                        } else if (state is PlayerPaused) {
                          context.read<PlayerBloc>().add(PlaySong(state.currentSong));
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next_rounded),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}