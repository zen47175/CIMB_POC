import 'package:flutter/material.dart';

class MainTitle extends StatelessWidget {
  final String text;
  final double fontSize;

  MainTitle({required this.text, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          color: Colors.black,
        ),
      ),
    );
  }
}
