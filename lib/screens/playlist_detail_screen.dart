import 'package:flutter/material.dart';
import 'package:musicplayer/models/mock_data.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String playlistTitle;

  const PlaylistDetailScreen({super.key, this.playlistTitle = "Daily Mix"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      // MARK: - Background
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0B192C), // Fallback-Farbe bis dein Bild da ist
          /* HIER MORGEN DAS BILD EINBINDEN:
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), 
            fit: BoxFit.cover,
          ),
          */
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              // MARK: - Playlist Header (Cover, Titel, Buttons)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // Großes Cover
                      Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.5),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                          // Das Gradient kann später auch durch ein Bild ersetzt werden
                          gradient: const LinearGradient(
                            colors: [Color(0xFF40FFEF), Color(0xFF8E2DE2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.music_note, size: 80, color: Colors.white54),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Titel
                      Text(
                        playlistTitle,
                        style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Verschiedene Künstler • 2h 14m",
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      
                      // MARK: - Play / Shuffle Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.play_arrow_rounded, size: 28),
                              label: const Text("Play All", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white12,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.shuffle, size: 24),
                              label: const Text("Shuffle", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // MARK: - Song Liste
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final song = recentlyPlayed[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: 56,
                              height: 56,
                              color: Colors.white10,
                              child: const Icon(Icons.music_note, color: Colors.white38),
                            ),
                          ),
                          title: Text(song.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          subtitle: Text(song.artist, style: const TextStyle(color: Colors.white54)),
                          // Der Play-Button direkt in der Liste!
                          trailing: IconButton(
                            icon: const Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 40),
                            onPressed: () {
                              // Hier kommt später die Logik rein, um diesen spezifischen Track zu starten
                            },
                          ),
                        ),
                      );
                    },
                    childCount: recentlyPlayed.length,
                  ),
                ),
              ),
              
              // Abstand für den MiniPlayer, damit der letzte Song nicht verdeckt wird
              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),
        ),
      ),
    );
  }
}