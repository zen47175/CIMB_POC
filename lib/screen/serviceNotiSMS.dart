import 'package:flutter/material.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customField.dart';
import 'package:poc_cimb/widget/mainTitle.dart';

class ServiceNotiSMS extends StatefulWidget {
  ServiceNotiSMS({Key? key}) : super(key: key);

  @override
  _ServiceNotiSMSState createState() => _ServiceNotiSMSState();
}

class _ServiceNotiSMSState extends State<ServiceNotiSMS> {
  int _value = 1;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            MainTitle(
              text: 'บริการการแจ้งเตือนผ่าน SMS',
              fontSize: 16,
            ),
            SizedBox(height: 23),
            ListView(
              shrinkWrap:
                  true, // allows the ListView to size itself based on children's height
              physics:
                  NeverScrollableScrollPhysics(), // to disable ListView's scrolling
              children: <Widget>[
                RadioListTile(
                  title: const Text('บัตรเครดิต'),
                  value: 1,
                  groupValue: _value,
                  onChanged: (int? value) {
                    setState(() {
                      _value = value!;
                    });
                  },
                ),
                if (_value == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: CustomFormField(
                      hintText: 'กรุณากรอกเลขบัตรเครดิต 4 ตัวท้ายของคุณ',
                      controller: _controller,
                    ),
                  ),
                RadioListTile(
                  title: const Text('บัญชีเงินฝาก'),
                  value: 2,
                  groupValue: _value,
                  onChanged: (int? value) {
                    setState(() {
                      _value = value!;
                    });
                  },
                ),
                if (_value == 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: CustomFormField(
                      hintText: 'กรุณากรอกเลขบัตรเครดิต 4 ตัวท้ายของคุณ',
                      controller: _controller,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
