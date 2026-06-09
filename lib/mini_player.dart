// lib/widgets/mini_player.dart

import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8), // Kleiner Abstand zum Rand
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest, // M3 Hintergrund
        borderRadius: BorderRadius.circular(24), // Starke Rundung wie im Entwurf
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
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
    );
  }
}