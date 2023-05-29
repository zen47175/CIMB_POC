import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poc_cimb/screen/registerScreen/agreementAndPolicyScreen.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isButtonDisabled = true.obs;
  String phoneValue = '';
  ConfirmationResult? confirmationResult;

  @override
  void onInit() {
    super.onInit();
    pinController.addListener(() {
      update();
    });
  }

  void updateButtonState(String value) {
    if (value.length == 6) {
      isButtonDisabled.value =
          false; // enable the button when the OTP length is 6
    } else {
      isButtonDisabled.value = true; // disable the button otherwise
    }
  }

  void updatePhoneValue(String value) {
    phoneValue = value;
  }

  void updateConfirmationResult(ConfirmationResult result) {
    confirmationResult = result;
  }

  void verifyOtp() async {
    try {
      EasyLoading.show(status: 'Verifying OTP...');
      await confirmationResult!.confirm(pinController.text);
      print(pinController.text);
      EasyLoading.dismiss();

      // Show Snackbar and then go to the next screen
      Get.snackbar('Correct', "Your OTP is correct",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.all(16),
          isDismissible: true,
          colorText: Colors.white,
          maxWidth: Get.width * 0.9);

      await Future.delayed(const Duration(seconds: 2));

      Get.to(() => AgreementAndPolicy());
    } catch (e) {
      EasyLoading.dismiss();

      pinController.clear();
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

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
