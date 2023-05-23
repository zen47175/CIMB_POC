import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String text;
  final bool isToggled;
  final ValueChanged<bool>? onChanged;

  const NotificationItem({
    Key? key,
    required this.text,
    this.isToggled = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      title: Text(text),
      trailing: CupertinoSwitch(
        value: isToggled,
        onChanged: onChanged,
        activeColor: Colors.green,
        trackColor: Colors.white,
        thumbColor: isToggled ? Colors.white : Colors.white,
      ),
    );
  }
}
