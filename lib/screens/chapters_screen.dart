// ignore_for_file: unused_import, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'dart:async';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'dart:math';

class ChapterScreen extends StatelessWidget {
  ChapterScreen({super.key, required this.intervalMin, required this.intervalMax});
  final int totalTimeInSeconds = 5; //15 * 60;
  final int intervalMin;
  final int intervalMax;
  final _random = Random();
  double timeElapsed = 0;
  late Countdown chapterCountdown;
  late Countdown invisibleCountdown;
  //DateTime dateTime = DateTime.now();
  final CountdownController chapterController = CountdownController(autoStart: true);
  final CountdownController invisibleController = CountdownController(autoStart: true);
  bool alertUnderway = false;

  Future<void> _showMyDialog(BuildContext context) async {
    //int intervalInSeconds = intervalMin + _random.nextInt(intervalMax - intervalMin);
    print('showMyDialogue, pausing invisible countdown');
    invisibleController.pause();
    alertUnderway = true;
    print('showMyDialogue, pausing chapter countdown');
    chapterController.pause();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ALIEN EVENT!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('Time elapsed this Chapter:${timeElapsed.floor()} seconds')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Resume Chapter'),
              onPressed: () {
                print('showMyDialogue, resuming chapter countdown');
                chapterCountdown.controller?.resume();
                Navigator.of(context).pop();
                alertUnderway = false;
                if (timeElapsed < 14.5 * 60) {
                  print('showMyDialogue, restarting invisible countdown');
                  invisibleCountdown.controller?.restart();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String _minutes = "00";
    String _seconds = "00";
    String _milliseconds = "00";
    chapterCountdown = Countdown(
      controller: chapterController,
      seconds: totalTimeInSeconds,
      build: (BuildContext context, double chapterTime) {
        _minutes = (chapterTime / 60).floor().toString();
        ;
        if ((chapterTime / 60).floor() < 10) {
          _minutes = "0$_minutes";
        }
        _seconds = (chapterTime % 60).round().toString();
        if ((chapterTime % 60).round() < 10) {
          _seconds = "0$_seconds";
        }
        _milliseconds = (chapterTime.toString()).split('.')[1];
        if (_milliseconds.length < 2) {
          _milliseconds = "0$_milliseconds";
        }
        timeElapsed = totalTimeInSeconds - chapterTime;
        return Material(
          child: Text(
            "$_minutes:$_seconds:$_milliseconds",
            style: GoogleFonts.shareTechMono(
              textStyle: const TextStyle(
                  backgroundColor: Color.fromARGB(255, 71, 71, 71),
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 60, 255, 66),
                  fontSize: 52.0),
            ),
          ),
        );
      },
      interval: const Duration(milliseconds: 100),
      onFinished: () {
        Navigator.of(context).pop();
      },
    );
    invisibleCountdown = Countdown(
      controller: invisibleController,
      seconds: _random.nextInt(10), //intervalMin + _random.nextInt(intervalMax - intervalMin),
      build: (BuildContext context, double invisibleTime) {
        return const SizedBox.shrink();
      },
      interval: const Duration(milliseconds: 100),
      onFinished: () {
        if (!alertUnderway) {
          _showMyDialog(context);
        }
      },
    );
    //int intervalInSeconds = intervalMin + _random.nextInt(intervalMax - intervalMin);
    //int intervalInSeconds = 5;
    //print('next event in $intervalInSeconds seconds');
    //Future.delayed(Duration(seconds: intervalInSeconds), () {
    //  _showMyDialog(context);
    //});
    return Center(
      child: Stack(
        children: [
          Image.asset('images/background2.jpg'),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Spacer(),
              Material(
                color: Colors.black.withOpacity(0),
                child: Text(
                  'Chapter One: Invasion',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.shareTechMono(
                    textStyle: const TextStyle(
                        backgroundColor: Color.fromARGB(255, 107, 54, 54),
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 205, 237, 131),
                        fontSize: 52.0),
                  ),
                ),
              ),
              const Spacer(),
              Center(
                child: chapterCountdown,
              ),
              Center(child: invisibleCountdown),
              const Spacer(
                flex: 2,
              ),
            ],
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