import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/controller/addNewCardController.dart';
import 'package:poc_cimb/controller/signinController.dart';
import 'package:poc_cimb/screen/registerScreen/otpScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customField.dart';

class SigninScreen extends StatelessWidget {
  final SigninController _controller = Get.put(SigninController());
  final AddNewCardController addNewCardController =
      Get.put(AddNewCardController());

  @override
  Widget build(BuildContext context) {
    double increaseSize(double value) {
      return value *
          (MediaQuery.of(context).size.width /
              375.0); // Adjust based on the design width (375 in this case)
    }

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05, // 5% of screen width
          top: MediaQuery.of(context).size.width * 0.05, // 5% of screen width
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'กรุณากรอกข้อมูลเพื่อลงทะเบียนกับ CIMB Thailand',
              style: TextStyle(
                fontSize: increaseSize(14),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: increaseSize(20)),
            Container(
              width: increaseSize(328),
              height: increaseSize(36),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(increaseSize(8)),
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
                      13), // limit input to 13 characters
                  FilteringTextInputFormatter.digitsOnly, // allow only digits
                ],
              ),
            ),
            SizedBox(height: increaseSize(10)),
            Container(
              width: increaseSize(328),
              height: increaseSize(36),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(increaseSize(8)),
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
                      10), // limit input to 10 characters
                  FilteringTextInputFormatter.digitsOnly, // allow only digits
                ],
              ),
            ),
            SizedBox(height: increaseSize(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: _controller.cancel,
                        child: const Text('ยกเลิก'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[300],
                          onPrimary: Colors.black, // text color
                          padding: EdgeInsets.symmetric(
                            vertical: increaseSize(8),
                            horizontal: increaseSize(16),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                increaseSize(8)), // border radius
                          ),
                        ),
                      ),
                      SizedBox(
                          width: increaseSize(
                              12)), // Space between the two buttons
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
                    ],
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
