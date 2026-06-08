import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Center(
          child: Text('Home-Screen layout comming sooooon!'),
        ),
      ),
      bottomNavigationBar: NavigationBar(
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
    );
  }
}