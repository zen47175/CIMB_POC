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
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ตั้งค่าการเเจ้งเตือนผลิตภัณท์',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.only(left: 16),
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Container(
        //       height:
        //           1.0, // H: 0 pt (A line height of 0 pt would be invisible, so we use 1 pt)
        //       width: 316, // W: 316 pt
        //       decoration: const BoxDecoration(
        //         border: Border(
        //           top: BorderSide(
        //             width: 1.0, // Width: 1 pt
        //             color: Color.fromRGBO(
        //                 229, 229, 229, 1.0), // rgba 0.9, 0.9, 0.9, 1.0
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 24,
        ),
        Container(
          margin: const EdgeInsets.only(top: 0, left: 20.0),
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: const Color.fromRGBO(230, 230, 230, 1.0),
          //     width: 1.0,
          //   ),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                  'assets/images/cardMock.png'), // replace with your image asset
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: const [
              //     Text(
              //       'บัตรเครดิต CIMB',
              //       style: TextStyle(
              //         fontSize: 14.0, // replace with your font size
              //         color: Colors.grey,
              //         height:
              //             1.4, // line height is usually defined as a multiplier of font size
              //         letterSpacing: -0.2,
              //       ),
              //     ),
              //      Text(
              //       'xxxx-xxxx',
              //       style: TextStyle(
              //         fontSize: 14.0, // replace with your font size
              //         color: Colors.grey,
              //         height:
              //             1.4, // line height is usually defined as a multiplier of font size
              //         letterSpacing: -0.2,
              //       ),
              //     ),
              //     const Text(
              //       'บัตรหลัก',
              //       style: TextStyle(
              //         fontSize: 14.0, // replace with your font size
              //         color: Colors.grey,
              //         height:
              //             1.4, // line height is usually defined as a multiplier of font size
              //         letterSpacing: -0.2,
              //       ),
              //     ),
              //   ],
              // ),
              //   Switch(
              //     value: true, // replace with your boolean control variable
              //     onChanged: (value) {
              //       // handle switch state change
              //     },
              //   ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 16),
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Container(
        //       height:
        //           1.0, // H: 0 pt (A line height of 0 pt would be invisible, so we use 1 pt)
        //       width: 316, // W: 316 pt
        //       decoration: const BoxDecoration(
        //         border: Border(
        //           top: BorderSide(
        //             width: 1.0, // Width: 1 pt
        //             color: Color.fromRGBO(
        //                 229, 229, 229, 1.0), // rgba 0.9, 0.9, 0.9, 1.0
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
              '*กรุณาเพิ่มบัตรดครดิต CIMB Thai Debit ของคุณ เพื่อรับข้อความเเจ้งเตือน'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.to(() => ServiceNotiSMS());
            // Get.to(() => SmsCardSettingScreen());
          },
          child: const Text('เพิ่มบัตร'),
          style: ElevatedButton.styleFrom(
            primary: const Color.fromRGBO(
                120, 0, 10, 1), // replace with actual color values
            minimumSize: const Size(300, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // corner radius
            ),
          ),
        )
      ]),
    );
  }
}
