import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'dart:async';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'dart:math';

class CustomAlert extends StatelessWidget {
  const CustomAlert({super.key, required this.timeElapsed});
  final double timeElapsed;

  dialogContent(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Image.asset('images/alert_background.png', height: 100),
          Center(child: Text('ALIEN EVENT!\r\n\r\nTime elapsed this Chapter:${timeElapsed.floor()} seconds')),
          //SizedBox(height: 16.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }
}
