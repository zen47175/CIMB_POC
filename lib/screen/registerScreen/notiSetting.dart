import 'package:flutter/material.dart';
import 'package:poc_cimb/screen/serviceNotiSMS.dart';
import 'package:poc_cimb/screen/smsCardSettingScreen.dart';

import 'package:poc_cimb/screen/smsSettingScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:get/get.dart';

class NotiSettingMainScreen extends StatelessWidget {
  const NotiSettingMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(children: [
        const SizedBox(
          height: 46, // 40 * 1.15
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 23), // 20 * 1.15
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ตั้งค่าการเเจ้งเตือนผลิตภัณท์',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 17.25), // 15 * 1.15
            ),
          ),
        ),
        const SizedBox(
          height: 27.6, // 24 * 1.15
        ),
        Container(
          margin: const EdgeInsets.only(top: 0, left: 23.0), // 20 * 1.15
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                  'assets/images/cardMock.png'), // replace with your image asset
            ],
          ),
        ),
        const SizedBox(
          height: 27.6, // 24 * 1.15
        ),
        const Padding(
          padding: EdgeInsets.all(23), // 20 * 1.15
          child: Text(
              '*กรุณาเพิ่มบัตรเดบิต CIMB Thai Debit ของคุณเพื่อรับข้อความเเจ้งเตือน',
              style: TextStyle(fontSize: 17.25) // 15 * 1.15
              ),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(() => ServiceNotiSMS());
          },
          child: const Text('เพิ่มบัตร',
              style: TextStyle(fontSize: 17.25)), // 15 * 1.15
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(
                120, 0, 10, 1), // replace with actual color values
            minimumSize: const Size(345, 41.4), // 300 * 1.15, 36 * 1.15
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.2), // 8 * 1.15
            ),
          ),
        )
      ]),
    );
  }
}
