// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:poc_cimb/screen/agreementAndPolicyScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';

class OtpScreen extends StatefulWidget {
  final ConfirmationResult confirmationResult;
  const OtpScreen({
    Key? key,
    required this.confirmationResult,
  }) : super(key: key);
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();

  final focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();

    pinController.addListener(() {
      if (pinController.text.length == 6) {
        // assuming OTP length is 6
        setState(() {
          _isButtonDisabled = false;
        });
      } else {
        setState(() {
          _isButtonDisabled = true;
        });
      }
    });
  }

  void _verifyOtp() async {
    try {
      await widget.confirmationResult.confirm(pinController.text);
      // If the OTP is verified, show Snackbar and then go to the next screen
      Get.snackbar('Correct', "Your pincode is correct",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.all(16),
          isDismissible: true,
          colorText: Colors.white,
          maxWidth: Get.width * 0.9);

      // Wait for 2 seconds before going to the next screen
      await Future.delayed(Duration(seconds: 2));

      Get.to(() => AgreementAndPolicy());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        print('The provided verification code is invalid.');
        // Show some error message
        Get.snackbar('Incorrect', "The provided verification code is invalid.",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            margin: const EdgeInsets.all(16),
            isDismissible: true,
            colorText: Colors.white,
            maxWidth: Get.width * 0.9);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorderColor = const Color.fromRGBO(245, 245, 245, 1);
    ;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 42,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
    );
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ขอระบุ otp เพื่อยินยันตัวตน',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            const Text(
              'รหัส otp 6 หลักถูกส่งไปที่',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'abcdfeg@gmail.com',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'รหัสมีอายุการใช้งาน x นาที',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(
              height: 42,
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        focusNode: focusNode,
                        length: 6,
                        androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        validator: (value) {
                          // return value == '2222' ? null : 'Pin is incorrect';
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
                child: Text(
              'ขอรหัส OTP อีกครั้ง(30 วิ)',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.withOpacity(0.5)),
            )),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: _isButtonDisabled
                  ? null
                  : () {
                      _verifyOtp();
                      print(_verifyOtp);
                      Get.to(() => AgreementAndPolicy());
                    },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF790009),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              child: const SizedBox(
                width: 342,
                height: 28,
                child: Center(
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
