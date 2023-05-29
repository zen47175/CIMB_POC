import 'package:flutter/material.dart';
import 'dart:async';

class Countdown extends StatefulWidget {
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  int _counter = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'ขอรหัส OTP อีกครั้ง (${_counter} วิ)',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
