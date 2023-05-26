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
  final String? lineId = FlutterLineLiff().id;
  final RxBool isValidInput = false.obs;

  @override
  void onInit() {
    super.onInit();
    idController.addListener(_validateInput);
    phoneController.addListener(_validateInput);
    _validateInput();
    getLiffId();
    update();
  }

  void _validateInput() {
    isValidInput.value =
        idController.text.length == 13 && phoneController.text.length == 10;
    print(isValidInput.value);
  }

  void getLiffId() async {
    FlutterLineLiff().ready.then((_) async {
      final String version = FlutterLineLiff().version;

      final Profile profile = await FlutterLineLiff().profile;

      print(profile);
      print(lineId);
      print(version);
    });
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

      // Create new user instance
      AppUser newUser = AppUser(
        id: idController.text,
        phone: phoneController.text,
        pincode: '',
        lineUID: lineId.toString(),
        notificationCenter: false,
        userProducts: [
          Product(
            productName: 'บัตรเครดิต CIMB Thai Credit Card',
            productDetails: '7733-38xx-xxxx-9080',
            type: 'Credit',
            toggles: [
              Toggle(name: 'รายการใช้จ่าย', value: false),
              Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: false),
              Toggle(name: 'ถอนเงินสด', value: false),
              Toggle(name: 'ชำระเงิน', value: false),
            ],
            id: '1',
          ),
          Product(
            productName: 'บัตรเดบิต CIMB Thai Debit Card (Banking Account)',
            productDetails: '7733-38xx-xxxx-2243',
            type: 'Debit',
            toggles: [
              Toggle(name: 'รายการใช้จ่าย', value: false),
              Toggle(name: 'ฝากเงิน', value: false),
              Toggle(name: 'ถอนเงิน', value: false),
              Toggle(name: 'โอนเงิน', value: false),
              Toggle(name: 'ชำระเงิน', value: false),
            ],
            id: '2',
          ),
          Product(
            productName: 'บัตรเครดิต CIMB Thai Credit Card',
            productDetails: '7733-38xx-xxxx-9080',
            type: 'Credit',
            toggles: [
              Toggle(name: 'รายการใช้จ่าย', value: false),
              Toggle(name: 'ยกเลิกรายการใช้จ่าย', value: false),
              Toggle(name: 'ถอดเงินสด', value: false),
              Toggle(name: 'ชำระเงิน', value: false),
            ],
            id: '3',
          ),
          Product(
            productName: 'สินเชื่อบ้าน',
            productDetails: 'xxxx-xxx-xxxx-xxxx',
            type: 'Loan',
            toggles: [
              Toggle(name: 'ครบกำหนดชำระ', value: false),
              Toggle(name: 'ชำระค่างวด', value: false),
            ],
            id: '4',
          ),
          Product(
            productName: 'สินเชื่อรถ',
            productDetails: 'xxxx-xxx-xxxx-xxxx',
            type: 'Loan',
            toggles: [
              Toggle(name: 'ครบกำหนดชำระ', value: false),
              Toggle(name: 'ชำระค่างวด', value: false),
            ],
            id: '5',
          ),
        ],
      );

      final User? firebaseUser = _auth.currentUser;
      await _firestore
          .collection('Users')
          .doc(firebaseUser?.uid)
          .set(newUser.toMap());
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
