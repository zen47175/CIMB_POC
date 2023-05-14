import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poc_cimb/screen/notiSetting.dart';
import 'package:poc_cimb/screen/smsSettingScreen.dart';
import 'package:poc_cimb/widget/confirmButton.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:get/get.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            size: 100,
            color: Colors.black,
          ),
          SizedBox(
            height: 24,
          ),
          const Text('ขอบคุณที่ลงทะเบียนกับ CIMB ค่ะ'),
          SizedBox(
            height: 40,
          ),
          ConfirmButton(
            mainText: 'ตกลง',
            size: ConfirmButtonSize.mid,
            onPressed: () {
              Get.to(() => SmsSettingScreen());
            },
          )
        ],
      )),
    );
  }
}
