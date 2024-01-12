// ignore_for_file: unused_import, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'dart:async';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'dart:math';
//import 'package:xcom_app/screens/custom_alert.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key, required this.intervalMin, required this.intervalMax});
  final int intervalMin;
  final int intervalMax;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  //final int totalTimeInSeconds = 15 * 60 - 1;
  final int totalTimeInSeconds = 10; //for testing
  final _random = Random();
  double timeElapsed = 0;
  int chapterNumber = 1;
  late Countdown chapterCountdown;
  late Countdown invisibleCountdown;
  //DateTime dateTime = DateTime.now();

  final CountdownController chapterController = CountdownController(autoStart: true);
  final CountdownController invisibleController = CountdownController(autoStart: true);
  bool alertUnderway = false;

  Widget getBackgroundImage() {
    return Image.asset('images/background$chapterNumber.png');
  }

  String getChapterHeadline() {
    switch (chapterNumber) {
      case 6:
        return 'Chapter Six: TERMINATION';
      case 5:
        return 'Chapter Five: DOMINATION';
      case 4:
        return 'Chapter Four: OCCUPATION';
      case 3:
        return 'Chapter Three: INFESTATION';
      case 2:
        return 'Chapter Two: INFILTRATION';
      default:
        return 'Chapter One: INVASION';
    }
  }

  Color getCountdownColor(double chapterTime) {
    //normalize between 120 down to 0
    //zi = (xi – min(x)) / (max(x) – min(x)) * 100
    double hue = (chapterTime / totalTimeInSeconds) * 120;
    Color result = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
    return result;
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

        if ((chapterTime / 60).floor() < 10) {
          _minutes = "0$_minutes";
        }
        _seconds = (chapterTime % 60).round().toString();
        if ((chapterTime % 60).round() < 10) {
          _seconds = "0$_seconds";
        }
        _milliseconds = (chapterTime.toStringAsFixed(2).split('.')[1]);
        if (_milliseconds.length < 2) {
          _milliseconds = "0$_milliseconds";
        }
        timeElapsed = totalTimeInSeconds - chapterTime;
        return Material(
          child: Text(
            "$_minutes:$_seconds:$_milliseconds",
            style: GoogleFonts.shareTechMono(
              textStyle: TextStyle(
                  backgroundColor: Color.fromARGB(255, 71, 71, 71),
                  fontWeight: FontWeight.bold,
                  color: getCountdownColor(chapterTime),
                  fontSize: 52.0),
            ),
          ),
        );
      },
      interval: const Duration(milliseconds: 100),
      onFinished: () {
        _showChapterDialog(context);
      },
    );
    invisibleCountdown = Countdown(
      controller: invisibleController,
      //seconds: 5 + _random.nextInt(10), //intervalMin + _random.nextInt(intervalMax - intervalMin),
      seconds: 4,
      build: (BuildContext context, double invisibleTime) {
        return const SizedBox.shrink();
      },
      interval: const Duration(milliseconds: 100),
      onFinished: () {
        if (!alertUnderway) {
          _showAlertDialog(context);
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Stack(
          children: [
            getBackgroundImage(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(),
                Material(
                  color: Colors.black.withOpacity(0),
                  child: Text(
                    getChapterHeadline(),
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
      ),
    );
  }

  Future<void> _showChapterDialog(BuildContext context) async {
    //int intervalInSeconds = intervalMin + _random.nextInt(intervalMax - intervalMin);
    invisibleController.pause();
    alertUnderway = true;
    chapterController.pause();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              if (chapterNumber == 6) {
                Navigator.of(context).pop();
              } else {
                chapterNumber += 1;

                setState(() {
                  alertUnderway = false;
                  chapterController.restart();
                  invisibleController.restart();
                });
              }
            },
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'images/summary_background1.png',
                    width: 450,
                  ),
                  ColoredBox(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Container(
                    margin: EdgeInsets.all(8.0),
                    //padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.amber,
                        width: 3,
                      ),
                      //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Text(
                      chapterNumber == 6 ? 'Game Over' : 'Advance to next chapter',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          backgroundColor: Color.fromARGB(230, 21, 0, 1),
                          color: Colors.yellow,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    //int intervalInSeconds = intervalMin + _random.nextInt(intervalMax - intervalMin);
    invisibleController.pause();
    alertUnderway = true;
    chapterController.pause();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              chapterCountdown.controller?.resume();
              Navigator.of(context).pop();
              alertUnderway = false;
              if (timeElapsed < 14.5 * 60) {
                invisibleCountdown.controller?.restart();
              }
            },
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('images/alert_background_no_skull.png', height: 250),
                  const Text(
                    'ALIEN EVENT!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        backgroundColor: Color.fromARGB(100, 21, 0, 1),
                        color: Colors.yellow,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



/*
- 15 minute timer, indicating chapter number and name, visible  (ChapterSCREEN)
- invisible timer 30-90s for 1p, 30-60 for 2p, 15-60 for more
   - when triggered, pause all timers, display SCREEN with reminder of tasks that need to be completed
   - no timers may trigger when 14:30s into the chapter

   Invasion
   Infiltration
   Infestation
   Occupation
   Domination
   Termination
   */


  
        /*
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
                chapterCountdown.controller?.resume();
                Navigator.of(context).pop();
                alertUnderway = false;
                if (timeElapsed < 14.5 * 60) {
                  invisibleCountdown.controller?.restart();
                }
              },
            ),
          ],
        );
        */