import 'package:flutter/material.dart';
import 'package:poc_cimb/screen/notiSetting.dart';
import 'package:poc_cimb/screen/smsSettingScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:get/get.dart';

class AgreementAndPolicy extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _AgreementAndPolicyState createState() => _AgreementAndPolicyState();
}

class _AgreementAndPolicyState extends State<AgreementAndPolicy> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ข้อตกลงและเงื่อนไขการใช้บริการ',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'ส่วน Privacy Policy หรือบางคนเรียก นโยบายความเป็นส่วนตัว หรือ นโยบายคุ้มครองข้อมูลส่วนบุคคล คือเอกสารที่ระบุว่าเราจะขอข้อมูลอะไรของลูกค้าบ้าง? เราจะเก็บข้อมูลไว้ที่ไหน? เราจะเอาไปใช้ทำอะไรบ้าง? จะขอลบข้อมูลต้องติดต่อใคร? เราจะลบภายในกี่วัน? เป็นต้น'
                            'การเขียน T&Cs พูดง่ายๆคือเราจะเขียนยังไงก็ได้ตามการออกแบบธุรกิจ และ Business Model ของเรา แต่การเขียน Privacy Policy เราจำเป็นต้องครอบคลุมทุกๆประเด็นตามที่กฎหมาย PDPA ใหม่ของไทยกำหนดไว้ อาทิเช่น ลูกค้าต้องขอลบข้อมูลได'
                            'นโยบายคุ้มครองข้อมูลส่วนบุคคล คือเอกสารที่ระบุว่าเราจะขอข้อมูลอะไรของลูกค้าบ้าง? เราจะเก็บข้อมูลไว้ที่ไหน? เราจะเอาไปใช้ทำอะไรบ้าง? ',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          CheckboxListTile(
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
              });
            },
            title: const Text('ฉันยินยอมรับเงื่อนไข'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isChecked
                  ? () {
                      Get.to(() => NotiSettingMainScreen());
                    }
                  : null,
              child: const Text('ยืนยัน'),
            ),
          ),
        ],
      ),
    );
  }
}
