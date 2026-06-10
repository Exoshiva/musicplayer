import 'package:flutter/material.dart';
import '../screens/player_screen.dart'; // WICHTIG: Den Player-Screen importieren

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Mix Intro',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Various Artists',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
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
                  icon: const Icon(Icons.play_arrow_rounded, size: 32),
                  onPressed: () {},
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
  }
}