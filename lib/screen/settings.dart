import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/screen/registerScreen/signinScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/widget/mainTitle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';

class SettingsScreen extends StatelessWidget {
  Future<void> _launchURL() async {
    const url =
        'https://www.cimbthai.com/th/personal/home.html'; // replace with the website URL
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'จัดการข้อมูล',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              MainTitle(
                fontSize: 16,
                text: 'ตั้งค่า',
              ),
              ListTile(
                title: const Text('เพิ่มผลิตภัณฑ์'),
                onTap: () {
                  Get.to(() => AddNewCard());
                },
              ),
              // ListTile(
              //   title: const Text('เปิดปิดรับการแจ้งเตือนทั้งหมด'),
              //   onTap: () {
              //     // navigate to the specific screen
              //   },
              // ),
              const SizedBox(height: 20),
              const Text(
                'บริการ KKP Line connect',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('ข้อตกลงและเงื่อนไขการใช้บริการ'),
                onTap: _launchURL,
              ),
              ListTile(
                title: const Text('ยกเลิกบริการ CIMB Line connect'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('ยืนยัน'),
                        content: const Text(
                            'คุณแน่ใจหรือไม่ว่าต้องการยกเลิกบริการ?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('ยืนยัน'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Get.to(() => SigninScreen());
                            },
                          ),
                          TextButton(
                            child: const Text('ยกเลิก'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
