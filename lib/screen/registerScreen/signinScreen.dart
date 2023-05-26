import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/registerScreen/otpScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../controller/addNewCardController.dart';
import '../../controller/signinController.dart';

class SigninScreen extends StatelessWidget {
  final SigninController _controller = Get.put(SigninController());
  final AddNewCardController addNewCardController =
      Get.put(AddNewCardController());

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
                  color: const Color.fromRGBO(
                      229, 229, 229, 1), // RGB(0.898, 0.898, 0.898)
                  width: 1,
                ),
              ),
              child: CustomFormField(
                hintText: 'เลขบัตรประชาชน',
                controller: _controller.idController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(
                      13), // limit input to 4 digits
                  FilteringTextInputFormatter.digitsOnly, // allow only digits
                ],
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
                  color: const Color.fromRGBO(
                      229, 229, 229, 1), // RGB(0.898, 0.898, 0.898)
                  width: 1,
                ),
              ),
              child: CustomFormField(
                hintText: 'เบอร์โทรศัพท์',
                controller: _controller.phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(
                      10), // limit input to 4 digits
                  FilteringTextInputFormatter.digitsOnly, // allow only digits
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Row(children: [
                    ElevatedButton(
                      onPressed: _controller.cancel,
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
                    const SizedBox(width: 12), // Space between the two buttons
                    Obx(
                      () => ElevatedButton(
                        onPressed: _controller.isValidInput.value
                            ? _controller.requestOtp
                            : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: _controller.isValidInput.value
                              ? Colors.white
                              : Colors.black,
                          backgroundColor: _controller.isValidInput.value
                              ? Colors.black
                              : Colors.grey[300],
                        ),
                        child: const Text('ขอรหัส otp'),
                      ),
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
