import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/screen/otpScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customField.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isValidInput = false;
  @override
  void initState() {
    super.initState();
    _idController.addListener(_validateInput);
    _phoneController.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {
      _isValidInput =
          _idController.text.isNotEmpty && _phoneController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'กรุณากรอกข้อมูลเพื่อลงทะเบียนกับ CIMB Thailand',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Container(
              width: 328,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromRGBO(
                      229, 229, 229, 1), // RGB(0.898, 0.898, 0.898)
                  width: 1,
                ),
              ),
              child: CustomFormField(
                hintText: 'เลขบัตรประชาชน',
                controller: _idController,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 328,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color.fromRGBO(
                      229, 229, 229, 1), // RGB(0.898, 0.898, 0.898)
                  width: 1,
                ),
              ),
              child: CustomFormField(
                hintText: 'เบอร์โทรศัพท์มือถือ',
                controller: _phoneController,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Row(children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('ยกเลิก'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[300],
                        onPrimary: Colors.black, // text color
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // border radius
                        ),
                      ),
                    ),
                    SizedBox(width: 12), // Space between the two buttons
                    ElevatedButton(
                      onPressed: _isValidInput
                          ? () {
                              Get.to((() => OtpScreen()));
                              print('test');
                            }
                          : null, // The button is disabled when _isValidInput is false
                      style: ElevatedButton.styleFrom(
                        primary:
                            _isValidInput ? Colors.black : Colors.grey[300],
                        onPrimary: _isValidInput ? Colors.white : Colors.black,
                      ),
                      child: const Text('ขอรหัส otp'),
                    ),
                  ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
