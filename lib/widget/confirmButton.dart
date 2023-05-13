import 'package:flutter/material.dart';

enum ConfirmButtonSize { small, mid, full }

class ConfirmButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ConfirmButtonSize size;
  final String mainText;

  ConfirmButton({
    required this.onPressed,
    required this.size,
    required this.mainText,
  });

  double _getWidth() {
    switch (size) {
      case ConfirmButtonSize.small:
        return 80;
      case ConfirmButtonSize.mid:
        return 170;
      case ConfirmButtonSize.full:
        return 300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(mainText),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(120, 0, 10, 1),
        minimumSize: Size(_getWidth(), 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
