import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poc_cimb/widget/confirmButton.dart';
import 'package:poc_cimb/widget/creditcard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/mainTitle.dart';

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
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: MainTitle(
                  text: 'ตั้งค่าการแจ้งเตือนผลิตภัณฑ์',
                  fontSize: 17,
                )),
            const SizedBox(
              height: 24,
            ),
            Container(
              height: 1,
              color: Color.fromRGBO(229, 229, 229, 1),
            ),
            CreditCard(
              isToggle: true,
            ),
            Container(
              height: 1,
              color: Color.fromRGBO(229, 229, 229, 1),
            ),
            const SizedBox(
              height: 40,
            ),
            ConfirmButton(
              mainText: 'เพิ่มบัตร',
              onPressed: () {},
              size: ConfirmButtonSize.full,
            )
          ],
        ),
      ),
    );
  }
}
