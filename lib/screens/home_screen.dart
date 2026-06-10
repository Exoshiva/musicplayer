import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:musicplayer/mini_player.dart';
import 'package:musicplayer/models/mock_data.dart';
//import 'package:radix_colors/radix_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Side-Navigation
      drawer: NavigationDrawer(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 24, 16, 16),
            child: Text(
              'Bibliothek',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add_box_rounded),
            title: const Text('Neue Playlist erstellen'),
            onTap: () {},
          ),
          const Divider(indent: 28, endIndent: 28),
          // Hier können später die lokalen Playlisten in einer ListView generiert werden
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Behält hintergrund bei
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Hier später den Settings-Screen anhängen!
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // 1. SearchBar Material 3
            const SearchBar(
              hintText: 'Songs, Alben oder Künstler suchen...',
              leading: Icon(Icons.search),
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.black12),
            ),
            const SizedBox(height: 24),
        
        // 2. Hero-Element with smooth gradient colors and strong rounded corners
        Container(
          height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF40FFEF),
                  Color(0xFF8E2DE2)
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4A00E0).withValues(alpha: 0.3), 
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Empfohlen',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Daily Mix',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 3. Action-Buttons right-side
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {}, 
                icon: const  Icon(Icons.favorite_border),
              ),
              const SizedBox(width: 8),
              FilledButton.tonalIcon(
                onPressed: () {}, 
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Play'),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Last Plays
          const Text(
            'Zuletzt gehört',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 240, // Fixed size for srollability
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyPlayed.length,
              itemBuilder: (context, index) {
                final song = recentlyPlayed[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                  // MARK: - 4. The Album-Cover
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        // 2. backdropFilter for Blur
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.10),
                                Colors.white.withValues(alpha: 0.7),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            // A Small Border
                            border: Border.all(
                              color: Colors.white.withValues(alpha:0.1),
                              width: 1,
                            ),
                          ),
                        // Centered Music-Icon
                        child: const Center(child: Icon(Icons.music_note_rounded, size: 56,
                        color: Colors.white38),
                        ),
                      ),
                    ),
                  ),
                    const SizedBox(height: 8),
                   
                    // Song title
                    Text(
                      song.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      ),
                      // Artist
                      Text(
                        song.artist,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    ),
  ),

      // MARK: - BottomNavigationBar
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min, // Attention! Column size to low as a posibile
        children:[
          const MiniPlayer(), // New Widget for Music-Player
          const SizedBox(height: 8),
      
          NavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (int index){
              // today no functions, UI-First!
            },
            destinations: const[
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
              label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.music_note),
                selectedIcon: Icon(Icons.music_note),
              label: 'Libary',
              ),
              NavigationDestination(
                icon: Icon(Icons.star),
                selectedIcon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],  
        ),
       ],
      ),
    );
  }
}