import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poc_cimb/widget/customAppbar.dart';

class SmsSettingScreen extends StatelessWidget {
  const SmsSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'ตั้งค่าการแจ้งเตือนผลิตภัณฑ์',
                style: TextStyle(
                  color: Color.fromRGBO(33, 33, 33, 1),
                  fontFamily: 'Inter',
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 1,
              color: Color.fromRGBO(229, 229, 229, 1),
            ),
            // Additional widgets go here.
          ],
        ),
      ),
    );
  }
}
