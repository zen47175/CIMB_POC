import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/controller/otpController.dart';
import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/registerScreen/otpScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import '../model/product.dart';
import '../model/toggle.dart';

class SigninController extends GetxController {
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final RxBool isValidInput = false.obs;

  @override
  void onInit() {
    super.onInit();
    idController.addListener(_validateInput);
    phoneController.addListener(_validateInput);
    _validateInput();
    // getLiffId();

    update();
  }

  void deleteUser() async {
    try {
      // Deleting the user from FirebaseAuth
      await _auth.currentUser!.delete();

      // Deleting the user from Firestore
      await _firestore.collection('Users').doc(_auth.currentUser!.uid).delete();

      // Showing a message after deletion
      Get.snackbar('Success', 'User deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      // Show error message
      Get.snackbar('Success', 'User deleted successfully',
          snackPosition: SnackPosition.BOTTOM);
      print(e);
    }
  }

  void closeLiffApp() {
    FlutterLineLiff().closeWindow();
  }

  void _validateInput() {
    isValidInput.value =
        idController.text.length == 13 && phoneController.text.length == 10;
    print(isValidInput.value);
  }

  Future<String> getLiffId() async {
    String userId = '';
    await FlutterLineLiff().ready.then((_) async {
      final Profile profile = await FlutterLineLiff().profile;
      userId = profile.userId;
      print(
          "Line User ID: $userId"); // This will print the LINE User ID to the console.
    });
    return userId;
  }

  @override
  void onClose() {
    idController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void cancel() {
    // Implement your cancel logic here
  }

  void requestOtp() async {
    try {
      // Show loading indicator
      EasyLoading.show(status: 'Requesting OTP...');

      // Start the phone number verification process
      final ConfirmationResult confirmationResult =
          await _auth.signInWithPhoneNumber('+66${phoneController.text}');

      Get.put(OtpController()).setConfirmationResult(confirmationResult);
      // OTP request successful, hide the loading indicator
      EasyLoading.dismiss();

      // Navigate to the OTP screen, passing the confirmationResult
      Get.to(() => const OtpScreen());
    } catch (e) {
      // If an error occurs, hide the loading indicator and display the error
      EasyLoading.dismiss();
      print('Failed to request OTP: ${e.toString()}');
      Get.snackbar('Error', "Failed to request OTP",
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
