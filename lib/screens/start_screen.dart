// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xcom_app/screens/chapters_screen.dart';
/*
import 'package:ktcg/screens/deck_selection_screen.dart';
import 'package:ktcg/screens/deckbuilding_screen.dart';
import 'package:ktcg/screens/full_screen.dart';
import 'package:ktcg/components/managers/game_manager.dart';
import 'package:provider/provider.dart';
import 'package:ktcg/components/managers/library_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';
*/

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  // this lets us edit our deck or launch a game, so we should initialize the player here
  // and load in their default deck

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset('images/start_screen_placeholder.jpg'),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero, // Set this
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            //GameManagerModel().newGame(saveFileName: saveFileName);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChapterScreen()),
            );
          },
          child: Text(
            '1 Player',
            style: GoogleFonts.shadowsIntoLightTwo(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0), fontSize: 14.0)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero, // Set this
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            //GameManagerModel().newGame(saveFileName: saveFileName);
            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => const FullScreen()),
            //MaterialPageRoute(builder: (context) => DeckSelectionScreen(saveFileName: saveFileName)),
            //);
          },
          child: Text(
            '2 Player',
            style: GoogleFonts.shadowsIntoLightTwo(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0), fontSize: 14.0)),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero, // Set this
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor: Colors.yellow,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            //GameManagerModel().newGame(saveFileName: saveFileName);
            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => const FullScreen()),
            //MaterialPageRoute(builder: (context) => DeckSelectionScreen(saveFileName: saveFileName)),
            //);
          },
          child: Text(
            '3+ Player',
            style: GoogleFonts.shadowsIntoLightTwo(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 0, 0), fontSize: 14.0)),
          ),
        ),
      ],
    );
  }
}
