import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:poc_cimb/controller/otpController.dart';
import 'package:poc_cimb/controller/signinController.dart';
import 'package:poc_cimb/widget/countdown.dart';
import 'package:poc_cimb/widget/customAppbar.dart';

class OtpScreen extends StatelessWidget {
  final ConfirmationResult confirmationResult;
  final String phoneValue;

  const OtpScreen({
    Key? key,
    required this.confirmationResult,
    required this.phoneValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpController = Get.put(OtpController());
    otpController.updatePhoneValue(phoneValue);
    otpController.updateConfirmationResult(confirmationResult);
    // otpController.phoneValue.value;
    // otpController.confirmationResult;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final focusedBorderColor = const Color.fromRGBO(245, 245, 245, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 42 * 1.15,
      height: 48 * 1.15,
      textStyle: const TextStyle(
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
        padding: const EdgeInsets.all(16.0 * 1.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ขอระบุ otp เพื่อยินยันตัวตน',
              style: TextStyle(fontSize: 20 * 1.15),
            ),
            const SizedBox(height: 10 * 1.15),
            const Text(
              'รหัส otp 6 หลักถูกส่งไปที่',
              style: TextStyle(fontSize: 16 * 1.15),
            ),
            const SizedBox(height: 5 * 1.15),
            Text(
              otpController.phoneValue,
              style: const TextStyle(
                  fontSize: 16 * 1.15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5 * 1.15),
            const Text(
              'รหัสมีอายุการใช้งาน 30 วินาที',
              style: TextStyle(fontSize: 16 * 1.15),
            ),
            const SizedBox(
              height: 42 * 1.15,
            ),
            Form(
              key: otpController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: otpController.pinController,
                        focusNode: otpController.focusNode,
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
                          otpController.updateButtonState(value);
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9 * 1.15),
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
            const SizedBox(
              height: 60 * 1.15,
            ),
            Center(
              child: GestureDetector(
                  onTap: SigninController().requestOtp, child: Countdown()),
            ),
            const SizedBox(
              height: 24 * 1.15,
            ),
            Obx(() => ElevatedButton(
                  onPressed: otpController.isButtonDisabled.value
                      ? null
                      : otpController.verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF790009),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12 * 1.15, horizontal: 16 * 1.15),
                  ),
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    height: 28 * 1.15,
                    child: const Center(
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
                )),
          ],
        ),
      ),
    );
  }
}
