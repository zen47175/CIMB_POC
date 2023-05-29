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
  // final AddNewCardController addNewCardController =
  //     Get.put(AddNewCardController());

  SigninScreen({super.key});

  Widget customContainer(String hintText, TextEditingController controller,
      int lengthLimit, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: const Color.fromRGBO(
              229, 229, 229, 1), // RGB(0.898, 0.898, 0.898)
          width: 1,
        ),
      ),
      child: CustomFormField(
        hintText: hintText,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(lengthLimit), // limit input
          FilteringTextInputFormatter.digitsOnly, // allow only digits
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'กรุณากรอกข้อมูลเพื่อลงทะเบียนกับ CIMB Thailand',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            customContainer(
                'เลขบัตรประชาชน', _controller.idController, 13, context),
            const SizedBox(height: 10),
            customContainer(
                'เบอร์โทรศัพท์', _controller.phoneController, 10, context),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _controller.cancel,
                  child: const Text('ยกเลิก'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[300],
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
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
          ],
        ),
      ),
    );
  }
}
