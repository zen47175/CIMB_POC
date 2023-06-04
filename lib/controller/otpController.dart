import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poc_cimb/controller/signinController.dart';
import 'package:poc_cimb/model/product.dart';
import 'package:poc_cimb/model/toggle.dart';
import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/registerScreen/agreementAndPolicyScreen.dart';

import '../screen/registerScreen/otpScreen.dart';

class OtpController extends GetxController {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool isButtonDisabled = true.obs;
  String phoneValue = '';
  // ConfirmationResult? confirmationResult;
  final TextEditingController idController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late ConfirmationResult confirmationResult;
  final _firestore = FirebaseFirestore.instance;
  SigninController signinController = Get.find();
  final RxBool isValidInput = true.obs;

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

  void setConfirmationResult(ConfirmationResult result) {
    confirmationResult = result;
  }

  void updatePhoneValue(String value) {
    phoneValue = value;
  }

  void updateConfirmationResult(ConfirmationResult result) {
    confirmationResult = result;
  }

  Future<void> verifyOtp() async {
    try {
      EasyLoading.show(status: 'Verifying OTP...');
      ConfirmationResult confirmationResult =
          Get.find<OtpController>().confirmationResult;
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
      // if (isValidInput.value) {
      // If no user exists with the id or phone, then create a new one

      // String lineUID = await getLiffId();
      // // Create new user instance
      // print(lineUID);
      //   try {
      //     AppUser newUser = AppUser(
      //       id: idController.text,
      //       phone: phoneController.text,
      //       pincode: '',
      //       lineUID: '',
      //       notificationCenter: true,
      //       userProducts: [
      //         Product(
      //           productName: 'บัตรเครดิต CIMB Thai Credit Card',
      //           productDetails: '7733-38xx-xxxx-9080',
      //           type: 'CreditGold',
      //           toggles: [
      //             // Toggle(name: 'รายการใช้จ่าย', value: true),
      //             Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: true),
      //             Toggle(name: 'ถอนเงินสด', value: true),
      //             Toggle(name: 'ชำระเงิน', value: true),
      //           ],
      //           id: '1',
      //           selected: false,
      //         ),
      //         Product(
      //           productName: 'บัตรเดบิต CIMB Thai Debit Card',
      //           productDetails: '7733-38xx-xxxx-2243',
      //           type: 'Debit',
      //           toggles: [
      //             // Toggle(name: 'รายการใช้จ่าย', value: true),
      //             Toggle(name: 'ฝากเงิน', value: true),
      //             Toggle(name: 'ถอนเงิน', value: true),
      //             Toggle(name: 'โอนเงิน', value: true),
      //             Toggle(name: 'ชำระเงิน', value: true),
      //           ],
      //           id: '2',
      //           selected: false,
      //         ),
      //         Product(
      //           productName: 'บัตรเครดิต CIMB Thai Credit Card',
      //           productDetails: '7733-38xx-xxxx-2852',
      //           type: 'CreditSliver',
      //           toggles: [
      //             Toggle(name: 'รายการใช้จ่าย', value: true),
      //             Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: true),
      //             Toggle(name: 'ถอดเงินสด', value: true),
      //             Toggle(name: 'ชำระเงิน', value: true),
      //           ],
      //           id: '3',
      //           selected: false,
      //         ),
      //         Product(
      //           productName: 'สินเชื่อบ้าน',
      //           productDetails: 'xxxx-xxx-xxxx-xxxx',
      //           type: 'HomeLoan',
      //           toggles: [
      //             Toggle(name: 'ครบกำหนดชำระ', value: true),
      //             Toggle(name: 'ชำระค่างวด', value: true),
      //           ],
      //           id: '4',
      //           selected: false,
      //         ),
      //         Product(
      //           productName: 'สินเชื่อส่วนบุลคล',
      //           productDetails: 'xxxx-xxx-xxxx-xxxx',
      //           type: 'PersonalLoan',
      //           toggles: [
      //             Toggle(name: 'ครบกำหนดชำระ', value: true),
      //             Toggle(name: 'ชำระค่างวด', value: true),
      //           ],
      //           id: '5',
      //           selected: false,
      //         ),
      //       ],
      //     );

      //     final User? firebaseUser = _auth.currentUser;
      //     await _firestore
      //         .collection('Users')
      //         .doc(firebaseUser?.uid)
      //         .set(newUser.toMap());

      //     // DocumentSnapshot result =
      //     //     await _firestore.collection('Users').doc(firebaseUser?.uid).get();
      //     await Future.delayed(const Duration(seconds: 2));

      //     print(firebaseUser?.uid);
      Get.to(() => AgreementAndPolicy());
      //     // if (result.exists) {
      //     //   print(result);
      //     // } else {
      //     //   print("No data found");
      //     // }
      //   } on FirebaseException catch (e) {
      //     print(e);
      //     print(e.message);
      //   }
      // } else {
      //   // If a user exists with either the id or phone, show a popup
      //   final User? firebaseUser = _auth.currentUser;
      //   print(firebaseUser?.uid);
      //   showDialog(
      //     context: Get.context!,
      //     builder: (context) => AlertDialog(
      //       title: const Text('Error'),
      //       content: const Text(
      //           'A user with this ID or phone number already exists.'),
      //       actions: <Widget>[
      //         TextButton(
      //           child: const Text('OK'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ],
      //     ),
      //   );
      // }
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

  void createUser() async {
    // Check if a user with the same id or phone already exists
    // final QuerySnapshot idResult = await _firestore
    //     .collection('Users')
    //     .where('id', isEqualTo: idController.text)
    //     .get();

    // final QuerySnapshot phoneResult = await _firestore
    //     .collection('Users')
    //     .where('phone', isEqualTo: phoneController.text)
    //     .get();

    // if (idResult.docs.isEmpty && phoneResult.docs.isEmpty)
    //TODO don't forget to uncode check id
    if (isValidInput.value) {
      // If no user exists with the id or phone, then create a new one
      // final ConfirmationResult confirmationResult =
      //     await _auth.signInWithPhoneNumber('+66${phoneController.text}');

      String lineUID = await getLiffId();
      // Create new user instance
      // print(lineUID);
      try {
        AppUser newUser = AppUser(
          id: signinController.idController.text,
          phone: signinController.phoneController.text,
          pincode: '',
          lineUID: lineUID,
          // lineUID: 'Ua810f2b3b1db579a8543750bce83053e',
          notificationCenter: true,
          userProducts: [
            // Product(
            //   productName: 'บัตรเครดิต CIMB Thai Credit Card',
            //   productDetails: '7733-3812-xxxx-9080',
            //   type: 'CreditGold',
            //   toggles: [
            //     // Toggle(name: 'รายการใช้จ่าย', value: true),
            //     Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: true),
            //     Toggle(name: 'ถอนเงินสด', value: true),
            //     Toggle(name: 'ชำระเงิน', value: true),
            //   ],
            //   id: '1',
            //   selected: false,
            // ),
            Product(
              productName: 'บัตรเดบิต CIMB Thai Debit Card',
              productDetails: '7733-3845-1234-2243',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/6963/6963703.png',
              type: 'Debit',
              toggles: [
                // Toggle(name: 'รายการใช้จ่าย', value: true),
                Toggle(name: 'ถอนเงิน', value: true),
                Toggle(name: 'โอนเงิน', value: true),
                Toggle(name: 'รายการใช้จ่าย', value: true),
                Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: true),
              ],
              id: '1',
              selected: false,
            ),
            Product(
              productName: 'บัญชีเงินฝาก',
              productDetails: '4532-4311-2323-2341',
              type: 'BankAccount',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/512/2721/2721031.png',
              toggles: [
                // Toggle(name: 'ครบกำหนดชำระ', value: true),
                Toggle(name: 'ฝากเงิน', value: true),
                Toggle(name: 'ถอนเงิน', value: true),
              ],
              id: '2',
              selected: false,
            ),
            // Product(
            //   productName: 'บัตรเครดิต CIMB Thai Credit Card',
            //   productDetails: '7733-38xx-xxxx-2852',
            //   type: 'CreditSliver',
            //   toggles: [
            //     Toggle(name: 'รายการใช้จ่าย', value: true),
            //     Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: true),
            //     Toggle(name: 'ถอดเงินสด', value: true),
            //     Toggle(name: 'ชำระเงิน', value: true),
            //   ],
            //   id: '3',
            //   selected: false,
            // ),
            Product(
              productName: 'สินเชื่อบ้าน',
              productDetails: '2341-1234-5452-5315',
              type: 'HomeLoan',
              imageUrl:
                  'https://cdn-icons-png.flaticon.com/128/6676/6676703.png',
              toggles: [
                // Toggle(name: 'ครบกำหนดชำระ', value: true),
                Toggle(name: 'ชำระค่างวด', value: true),
              ],
              id: '3',
              selected: false,
            ),
            Product(
              productName: 'สินเชื่อส่วนบุลคล',
              productDetails: '4532-4311-2323-2341',
              type: 'PersonalLoan',
              imageUrl:
                  'https://static.vecteezy.com/system/resources/previews/005/911/349/original/dollar-icon-man-for-your-web-site-logo-app-ui-design-free-vector.jpg',
              toggles: [
                // Toggle(name: 'ครบกำหนดชำระ', value: true),
                Toggle(name: 'ชำระค่างวด', value: true),
              ],
              id: '4',
              selected: false,
            ),
          ],
        );

        final User? firebaseUser = _auth.currentUser;
        await _firestore
            .collection('Users')
            .doc(firebaseUser?.uid)
            .set(newUser.toMap());

        DocumentSnapshot result =
            await _firestore.collection('Users').doc(firebaseUser?.uid).get();
        if (result.exists) {
          print(result);
        } else {
          print("No data found");
        }
      } on FirebaseException catch (e) {
        print(e);
        print(e.message);
      }
    } else {
      // If a user exists with either the id or phone, show a popup
      final User? firebaseUser = _auth.currentUser;
      print(firebaseUser?.uid);
      // showDialog(
      //   context: Get.context!,
      //   builder: (context) => AlertDialog(
      //     title: const Text('Error'),
      //     content:
      //         const Text('A user with this ID or phone number already exists.'),
      //     actions: <Widget>[
      //       TextButton(
      //         child: const Text('OK'),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       ),
      //     ],
      //   ),
      // );
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    focusNode.dispose();
    super.onClose();
  }
}
