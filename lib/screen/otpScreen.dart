import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:poc_cimb/screen/agreementAndPolicyScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ขอระบุ otp เพื่อยินยันตัวตน',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'รหัส otp 6 หลักถูกส่งไปที่',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'abcdfeg@gmail.com',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'รหัสมีอายุการใช้งาน x นาที',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
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
            SizedBox(
              height: 60,
            ),
            Center(
                child: Text(
              'ขอรหัส OTP อีกครั้ง(30 วิ)',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.withOpacity(0.5)),
            )),
            SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => AgreementAndPolicy());
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF790009),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              child: SizedBox(
                width: 342,
                height: 28,
                child: const Center(
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
