import 'package:flutter/material.dart';
import 'package:xcom_app/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}



/*
- Opening SCREEN picture of xcom and choice of 1, 2, or more players
- 15 minute timer, indicating chapter number and name, visible  (ChapterSCREEN)
- invisible timer 30-90s for 1p, 30-60 for 2p, 15-60 for more
   - when triggered, pause all timers, display SCREEN with reminder of tasks that need to be completed
   - no timers may trigger when 14:30s into the chapter
- when chapter ends, reset all timers, SCREEN prompt for user to start next chapter
- music and graphics
*/