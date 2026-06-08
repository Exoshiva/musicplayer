import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MusicPlayerApp());
}

  class MusicPlayerApp extends StatelessWidget {
    const MusicPlayerApp({super.key});

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicPlayer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark, 
          seedColor: Colors.cyanAccent,
        ),

        // global Configuration
        navigationBarTheme: const NavigationBarThemeData(
          indicatorShape: StadiumBorder(),
        ),
      ),
      home: const HomeScreen(),
    );
  } 

}