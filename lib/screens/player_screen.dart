import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            AspectRatio(aspectRatio: 1,
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
                  begin:AlignmentGeometry.topLeft,
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Mix Intro',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Various Artists',
                        style: TextStyle(
                        fontSize: 16,
                          color: Colors.white54
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.star_border, size: 28),
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
              child: Slider(value: 0.3, onChanged: (value) {},
              ),
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

            // 4. Playback-Controlls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.shuffle, color: Colors.white54),
                onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.skip_previous, size: 40),
                  onPressed: () {},
                ),
                // The Big Play-Button (Center)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color:  Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(icon: const Icon(Icons.play_arrow_rounded, color: Colors.black, size: 48),
                  onPressed: () {},
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next, size:40),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.repeat, size:24, color: Colors.white54),
                  onPressed: () {},
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}