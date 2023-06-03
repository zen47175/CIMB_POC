import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/smsCardSettingScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customField.dart';
import 'package:poc_cimb/widget/mainTitle.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controller/otpController.dart';
import '../controller/signinController.dart';

class ServiceNotiSMS extends StatefulWidget {
  ServiceNotiSMS({Key? key}) : super(key: key);

  @override
  _ServiceNotiSMSState createState() => _ServiceNotiSMSState();
}

class _ServiceNotiSMSState extends State<ServiceNotiSMS> {
  int _value = 1;
  TextEditingController _controller = TextEditingController();
  TextEditingController _secondController = TextEditingController();
  FocusNode _secondFocusNode = FocusNode();
  bool _showNewFormField = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_firstFieldListener);
    _secondController.addListener(_secondFieldListener);
  }

  Future<void> _firstFieldListener() async {
    if (_controller.text.length == 4) {
      EasyLoading.show(status: 'Checking number...');
      final User? firebaseUser = _auth.currentUser;
      final userDoc = _firestore.collection('Users').doc(firebaseUser?.uid);
      final userDocSnapshot = await userDoc.get();

      if (userDocSnapshot.exists) {
        // Make updates to the existing user data
        final userData = userDocSnapshot.data() as Map<String, dynamic>;
        userData['pincode'] = _secondController.text; // Update the pin code

        final userProducts = userData['userProducts'] as List<dynamic>;
        if (userProducts.isNotEmpty) {
          final firstProduct = userProducts.first;
          if (firstProduct is Map<String, dynamic>) {
            firstProduct['productDetails'] =
                '7733-38xx-xxxx-${_controller.text}';
          }
        }

        // Save the updated user data back to Firestore
        await userDoc.set(userData);
      }
      await Future.delayed(Duration(seconds: 1)); // wait for 1 second

      EasyLoading.dismiss();
      Get.to(() => SmsCardSettingScreen());
      setState(() {
        _showNewFormField = true;
      });
      FocusScope.of(context).requestFocus(_secondFocusNode);
    } else {
      setState(() {
        _showNewFormField = false;
      });
    }
  }

  Future<void> _secondFieldListener() async {
    if (_secondController.text.length == 4) {
      EasyLoading.show(status: 'Setting pin code...');
      await Future.delayed(Duration(seconds: 1)); // wait for 1 second
      EasyLoading.dismiss();

      Get.snackbar('Success', "Your have set your pincode",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.green,
          margin: const EdgeInsets.all(16),
          isDismissible: true,
          colorText: Colors.white,
          maxWidth: Get.width * 0.9);

      final User? firebaseUser = _auth.currentUser;
      final userDoc = _firestore.collection('Users').doc(firebaseUser?.uid);
      final userDocSnapshot = await userDoc.get();

      if (userDocSnapshot.exists) {
        // Make updates to the existing user data
        final userData = userDocSnapshot.data() as Map<String, dynamic>;
        userData['pincode'] = _secondController.text; // Update the pin code

        final userProducts = userData['userProducts'] as List<dynamic>;
        if (userProducts.isNotEmpty) {
          final firstProduct = userProducts.first;
          if (firstProduct is Map<String, dynamic>) {
            firstProduct['productDetails'] =
                '7733-3832-1322-${_controller.text}';
          }
        }

        // Save the updated user data back to Firestore
        await userDoc.set(userData);

        Get.to(() => SmsCardSettingScreen());
      }
      print(_secondController.text);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_firstFieldListener);
    _secondController.removeListener(_secondFieldListener);
    _controller.dispose();
    _secondController.dispose();
    _secondFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            MainTitle(
              text: 'บริการการแจ้งเตือนผ่าน SMS',
              fontSize: 16,
            ),
            SizedBox(height: 23),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                RadioListTile(
                  title: const Text('บัตรเดบิต'),
                  value: 1,
                  groupValue: _value,
                  onChanged: (int? value) {
                    setState(() {
                      _value = value!;
                    });
                  },
                ),
                if (_value == 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: CustomFormField(
                      hintText: 'กรุณากรอกเลขบัตรเคบิต 4 ตัวท้ายของคุณ',
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(
                            4), // limit input to 4 digits
                        FilteringTextInputFormatter
                            .digitsOnly, // allow only digits
                      ],
                    ),
                  ),
                RadioListTile(
                  title: const Text('บัญชีเงินฝาก'),
                  value: 2,
                  groupValue: _value,
                  onChanged: (int? value) {
                    setState(() {
                      _value = value!;
                    });
                  },
                ),
                if (_value == 2)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: CustomFormField(
                      hintText: 'กรุณากรอกเลขบัญชี 4 ตัวท้ายของคุณ',
                      controller: _controller,
                    ),
                  ),
                SizedBox(
                  height: 40,
                ),
                // if (_showNewFormField)
                //   Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 44),
                //     child: CustomFormField(
                //       hintText: 'สร้างรหัสผ่านรหัสของคุณ',
                //       controller: _secondController,
                //       focusNode: _secondFocusNode,
                //       keyboardType: TextInputType.number,
                //       inputFormatters: <TextInputFormatter>[
                //         FilteringTextInputFormatter.digitsOnly,
                //         LengthLimitingTextInputFormatter(4)
                //       ],
                //     ),
                //   ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
