import 'package:flutter/material.dart';
import '../models/album.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final Album album;

  const AlbumDetailsScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF0B192C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // MARK: - Das Ziel der Hero-Animation: Das große Albumcover
            Center(child: 
              Hero(
                tag:album.id,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    image: DecorationImage(
                      image: AssetImage(album.coverPath), 
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Title and Artist
            Text(album.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(album.artist, style:const TextStyle(fontSize: 18, color: Colors.white54),
            ),
            const SizedBox(height: 20),
            // MARK: - Song List (Placeholder)
            const Text("Song List goes here...", style: TextStyle(color: Colors.white38)),
          ],
        )
      )
    );
  }
}