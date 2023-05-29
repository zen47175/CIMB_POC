import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poc_cimb/screen/registerScreen/agreementAndPolicyScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';

class OtpScreen extends StatefulWidget {
  final ConfirmationResult confirmationResult;
  final String phoneValue;

  const OtpScreen({
    Key? key,
    required this.confirmationResult,
    required this.phoneValue,
  }) : super(key: key);
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  late String phoneValue;
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    phoneValue = widget.phoneValue;
    pinController.addListener(() {
      if (pinController.text.length == 6) {
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _verifyOtp() async {
    try {
      EasyLoading.show(status: 'Verifying OTP...');
      await widget.confirmationResult.confirm(pinController.text);
      EasyLoading.dismiss();

      // If the OTP is verified, show Snackbar and then go to the next screen
      Get.snackbar('Correct', "Your OTP is correct",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.all(16),
          isDismissible: true,
          colorText: Colors.white,
          maxWidth: Get.width * 0.9);

      // Wait for 2 seconds before going to the next screen
      await Future.delayed(Duration(seconds: 2));

      Get.to(() => AgreementAndPolicy());
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();

      if (e.code == 'invalid-verification-code') {
        print('The provided verification code is invalid.');
        pinController.clear();
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final focusedBorderColor = const Color.fromRGBO(245, 245, 245, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 42 * 1.15,
      height: 48 * 1.15,
      textStyle: TextStyle(
        fontSize: 22 * 1.15,
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
        padding: EdgeInsets.all(16.0 * 1.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ขอระบุ otp เพื่อยินยันตัวตน',
              style: TextStyle(fontSize: 20 * 1.15),
            ),
            SizedBox(height: 10 * 1.15),
            Text(
              'รหัส otp 6 หลักถูกส่งไปที่',
              style: TextStyle(fontSize: 16 * 1.15),
            ),
            SizedBox(height: 5 * 1.15),
            Text(
              phoneValue,
              style:
                  TextStyle(fontSize: 16 * 1.15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5 * 1.15),
            Text(
              'รหัสมีอายุการใช้งาน 30 วินาที',
              style: TextStyle(fontSize: 16 * 1.15),
            ),
            SizedBox(
              height: 42 * 1.15,
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
                              margin: EdgeInsets.only(bottom: 9 * 1.15),
                              width: 22 * 1.15,
                              height: 1 * 1.15,
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
            SizedBox(
              height: 60 * 1.15,
            ),
            Center(
                child: GestureDetector(
              onTap: () async {
                final ConfirmationResult confirmationResult =
                    await _auth.signInWithPhoneNumber('+66${phoneValue}');
              },
              child: Text(
                'ขอรหัส OTP อีกครั้ง(30 วิ)',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.withOpacity(0.5)),
              ),
            )),
            SizedBox(
              height: 24 * 1.15,
            ),
            ElevatedButton(
              onPressed: _isButtonDisabled
                  ? null
                  : () {
                      _verifyOtp();
                      print(_verifyOtp);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF790009),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 12 * 1.15, horizontal: 16 * 1.15),
              ),
              child: SizedBox(
                width: screenWidth * 0.9,
                height: 28 * 1.15,
                child: Center(
                  child: Text(
                    'ยืนยัน',
                    style: TextStyle(
                      fontSize: 16 * 1.15,
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
