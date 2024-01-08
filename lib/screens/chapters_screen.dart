// ignore_for_file: unused_import, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'dart:async';
import 'package:timer_count_down/timer_count_down.dart';
/*
import 'package:ktcg/screens/deck_selection_screen.dart';
import 'package:ktcg/screens/deckbuilding_screen.dart';
import 'package:ktcg/screens/full_screen.dart';
import 'package:ktcg/components/managers/game_manager.dart';
import 'package:provider/provider.dart';
import 'package:ktcg/components/managers/library_manager.dart';

import 'package:shared_preferences/shared_preferences.dart';
*/

class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key});
  final int seconds = 15 * 60;

  @override
  Widget build(BuildContext context) {
    String _minutes = "00";
    String _seconds = "00";
    String _milliseconds = "00";
    return Center(
      child: Stack(
        children: [
          Image.asset('images/background2.jpg'),
          Center(
            child: Countdown(
              seconds: seconds,
              build: (BuildContext context, double time) {
                _minutes = (time / 60).floor().toString();
                if ((time / 60).floor() < 10) {
                  _minutes = "0$_minutes";
                }
                _seconds = (time % 60).round().toString();
                if ((time % 60).round() < 10) {
                  _seconds = "0$_seconds";
                }
                _milliseconds = (time.toString()).split('.')[1];
                if (_milliseconds.length < 2) {
                  _milliseconds = "0$_milliseconds";
                }
                return Material(
                  child: Text(
                    "$_minutes:$_seconds:$_milliseconds",
                    style: GoogleFonts.shareTechMono(
                      textStyle: const TextStyle(
                          backgroundColor: Color.fromARGB(255, 71, 71, 71),
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 60, 255, 66),
                          fontSize: 36.0),
                    ),
                  ),
                );
              },
              interval: const Duration(milliseconds: 100),
              onFinished: () {},
            ),
          ),
        ],
      ),
    );
  }
}


/*
- 15 minute timer, indicating chapter number and name, visible  (ChapterSCREEN)
- invisible timer 30-90s for 1p, 30-60 for 2p, 15-60 for more
   - when triggered, pause all timers, display SCREEN with reminder of tasks that need to be completed
   - no timers may trigger when 14:30s into the chapter
   */