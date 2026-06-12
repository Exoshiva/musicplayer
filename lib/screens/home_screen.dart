import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:musicplayer/mini_player.dart';
import 'package:musicplayer/models/mock_data.dart';
import 'package:musicplayer/screens/playlist_detail_screen.dart';
//import 'package:radix_colors/radix_colors.dart'; // maybe later?

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Der Container mit dem Gradienten umschließt jetzt ALLES
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF000000), // dark blue / cyan
            Color(0xFF000000), // dark blue / cyan
            Color(0xFF173A5E), // blue
            Color(0xFF0B192C), // low Petrol/Navy-Style
            Color(0xFF000000), // low Petrol/Navy-Style
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // 2. Der Scaffold ist jetzt transparent und liegt im Container
      child: Scaffold(
        backgroundColor: Colors.transparent, // <- WICHTIG!
        // erlaubt dem Body, HINTER die BottomnavigationBar zu fließen
        extendBody: true,
        // erlaubt dem Body, HINTER die obere SliverAppBar zu fließen
        extendBodyBehindAppBar: true, 
        
        // MARK: - Side-Navigation (Glass-Morphism)
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: const Color(0xFF0B192C).withValues(alpha: 0.6),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  ListTile(
                    leading: const Icon(Icons.equalizer),
                    title: const Text('Equalizer'),
                    onTap: () {},
                  ),
                  const Divider(indent: 28, endIndent: 28),
                  ListTile(
                    leading: const Icon(Icons.color_lens_rounded),
                    title: const Text('Theme-Mode'),
                    onTap: () {},
                  ),
                  const Divider(indent: 28, endIndent: 28),
                  ListTile(
                    leading: const Icon(Icons.album),
                    title: const Text('Alben'),
                    onTap: () {},
                  ),
                  const Divider(indent: 28, endIndent: 28),
                  ListTile(
                    leading: const Icon(Icons.auto_awesome),
                    title: const Text('Awesome'),
                    onTap: () {},
                  ),
                  const Divider(indent: 28, endIndent: 28),
                  ListTile(
                    leading: const Icon(Icons.widgets_rounded),
                    title: const Text('Widgets'),
                    onTap: () {},
                  ),
                  const Divider(indent: 28, endIndent: 28),

                  // MARK: - New Menüpoint
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Einstellungen'),
                    onTap: () {
                      // close drawer before a new screen opened
                      Navigator.pop(context);
                      // TODO! Setting Screen Navigation implement
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // 3. Der Body braucht keinen eigenen Container mehr
        body: CustomScrollView(
          slivers: [
            // 1. SilverAppBar Top
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ),
              ),
              actions: [
                /*IconButton(
                  icon: const Icon(Icons.settings_outlined, color: Colors.white),
                  onPressed: () {
                    // later hanging Setting-Screen implement
                  },
                ),*/
              ],
            ),

            // 2. remaining scrollable content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 120.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SearchBar
                    const SearchBar(
                      hintText: 'Songs, Alben oder Künstler suchen...',
                      leading: Icon(Icons.search, color: Colors.white70),
                      elevation: WidgetStatePropertyAll(0),
                      backgroundColor: WidgetStatePropertyAll(Colors.white10),
                      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 24),

                    // MARK: - 2. Hero-Element (Daily Mix)
                    // with smooth gradient colors and strong rounded corners
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1.5
                        ),
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
                            color: Colors.black.withValues(alpha: 0.6), // Kräftiges Schwarz statt Lila
                            blurRadius: 25, // Größerer Weichzeichner für das große Element
                            offset: const Offset(0, 15), // Weiter nach unten verschoben für mehr "Flughöhe"
                            spreadRadius: -2,
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

                    // MARK: - 3. Action-Buttons 
                    // right-side
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {}, 
                          icon: const Icon(Icons.favorite_border, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.tonalIcon(
                          onPressed: () {}, 
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Play'),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.white24,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    
                    // Last Plays and other sections
                    _buildAlbumSection('Zuletzt gehört'),
                    const SizedBox(height: 32),
                    _buildAlbumSection('Für dich Empfohlen'),
                    const SizedBox(height: 32),
                    _buildAlbumSection('Neuerscheinungen'),
                  ],
                ),
              ),
            ),
          ],
        ),

        // MARK: - BottomNavigationBar
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min, // Attention! Column size to low as a posibile
          children: [
            const MiniPlayer(), // Der MiniPlayer schwebt jetzt frei über dem Blur
            const SizedBox(height: 8),
            
            // Der Blur wird NUR auf die NavigationBar angewendet
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    // Hauchdünne Linie oben für einen sauberen "Glas"-Abschluss
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: NavigationBar(
                    backgroundColor: Colors.transparent, // Behält Hintergrund bei
                    elevation: 0,
                    indicatorColor: Colors.white.withValues(alpha: 0.15),
                    selectedIndex: 0,
                    onDestinationSelected: (int index) {
                      // today no functions, UI-First!
                    },
                    destinations: const [
                      NavigationDestination(
                        icon: Icon(Icons.home_outlined, color: Colors.white70),
                        selectedIcon: Icon(Icons.home, color: Colors.white),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.music_note, color: Colors.white70),
                        selectedIcon: Icon(Icons.music_note, color: Colors.white),
                        label: 'Library',
                      ),
                      NavigationDestination(
                        icon: Icon(Icons.star_outline, color: Colors.white70),
                        selectedIcon: Icon(Icons.star, color: Colors.white),
                        label: 'Favorites',
                      ),
                    ],  
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - Helper Methods
  Widget _buildAlbumSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 190, // Fixed size for scrollability
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recentlyPlayed.length,
            itemBuilder: (context, index) {
              final song = recentlyPlayed[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const PlaylistDetailScreen(playlistTitle: 'Zuletzt gehööört'),
                      ),
                    );
                  },
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // MARK: - 4. Album-Cover
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
                            border:Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.5), 
                                blurRadius: 15,
                                offset: const Offset(0, 8),
                                spreadRadius: -2,
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.10),
                                Colors.white.withValues(alpha: 0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            // A Small Border (entfernt, da oben als border:Border.all hinzugefügt)
                          ),
                          // Centered Music-Icon
                          child: const Center(
                            child: Icon(Icons.music_note_rounded,
                                size: 56, color: Colors.white38),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Song title
                    SizedBox(
                      width: 130,
                      child: Text(
                        song.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Artist
                    SizedBox(
                      width: 130,
                      child: Text(
                        song.artist,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              );
            },
          ),
        ),
      ],
    );
  }
}