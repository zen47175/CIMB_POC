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
      print("Line User ID: $userId");
    });
    print("getLiffId() is returning: $userId");
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
      final ConfirmationResult confirmationResult =
          await _auth.signInWithPhoneNumber('+66${phoneController.text}');

      Get.to(() => OtpScreen(
            confirmationResult: confirmationResult,
            phoneValue: phoneController.text,
          ));
      String lineUID = await getLiffId();
      // Create new user instance

      AppUser newUser = AppUser(
        id: idController.text,
        phone: phoneController.text,
        pincode: '',
        lineUID: lineUID,
        notificationCenter: true,
        userProducts: [
          Product(
            productName: 'บัตรเครดิต CIMB Thai Credit Card',
            productDetails: '7733-38xx-xxxx-9080',
            type: 'CreditGold',
            toggles: [
              Toggle(name: 'รายการใช้จ่าย', value: true),
              Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: true),
              Toggle(name: 'ถอนเงินสด', value: true),
              Toggle(name: 'ชำระเงิน', value: true),
            ],
            id: '1',
          ),
          Product(
            productName: 'บัตรเดบิต CIMB Thai Debit Card (Banking Account)',
            productDetails: '7733-38xx-xxxx-2243',
            type: 'Debit',
            toggles: [
              Toggle(name: 'รายการใช้จ่าย', value: true),
              Toggle(name: 'ฝากเงิน', value: true),
              Toggle(name: 'ถอนเงิน', value: true),
              Toggle(name: 'โอนเงิน', value: true),
              Toggle(name: 'ชำระเงิน', value: true),
            ],
            id: '2',
          ),
          Product(
            productName: 'บัตรเครดิต CIMB Thai Credit Card',
            productDetails: '7733-38xx-xxxx-9080',
            type: 'CreditSliver',
            toggles: [
              Toggle(name: 'รายการใช้จ่าย', value: true),
              Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: true),
              Toggle(name: 'ถอดเงินสด', value: true),
              Toggle(name: 'ชำระเงิน', value: true),
            ],
            id: '3',
          ),
          Product(
            productName: 'สินเชื่อบ้าน',
            productDetails: 'xxxx-xxx-xxxx-xxxx',
            type: 'HomeLoan',
            toggles: [
              Toggle(name: 'ครบกำหนดชำระ', value: true),
              Toggle(name: 'ชำระค่างวด', value: true),
            ],
            id: '4',
          ),
          Product(
            productName: 'สินเชื่อส่วนบุลคล',
            productDetails: 'xxxx-xxx-xxxx-xxxx',
            type: 'PersonalLoan',
            toggles: [
              Toggle(name: 'ครบกำหนดชำระ', value: true),
              Toggle(name: 'ชำระค่างวด', value: true),
            ],
            id: '5',
          ),
        ],
      );

      // final User? firebaseUser = _auth.currentUser;
      await _firestore.collection('Users').doc(lineUID).set(newUser.toMap());
    } else {
      // If a user exists with either the id or phone, show a popup
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content:
              const Text('A user with this ID or phone number already exists.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
