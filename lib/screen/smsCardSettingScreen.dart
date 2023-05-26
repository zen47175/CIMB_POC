import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/mainTitle.dart';

import '../controller/SmsCardSettingController.dart';

class SmsCardSettingScreen extends StatelessWidget {
  // final SmsCardSettingController controller =
  //     Get.put(SmsCardSettingController());
  final SmsCardSettingController controller =
      Get.put(SmsCardSettingController());

  SmsCardSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.user.value == null) {
        return const Center(
          child: Text("No user data available"),
        );
      } else {
        return Scaffold(
          appBar: CustomAppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MainTitle(
                    text: 'ตั้งค่าบริการการแจ้งเตือนผ่าน SMS',
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 1.0,
                      width: 316,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: Color.fromRGBO(229, 229, 229, 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 328,
                  height: 210,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/Creditcard.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  controller.user.value!.userProducts[0]!.productName ?? '',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF790009),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.user.value!.userProducts[0]!.productDetails ?? '',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '(บัตรหลัก)',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'ยอดการใช้จ่ายผ่านบัตร',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      CupertinoSwitch(
                        value:
                            controller.user.value!.notificationCenter ?? true,
                        activeColor: Colors.black,
                        onChanged: (bool value) async {
                          controller.user.value!.notificationCenter = value;

                          // Update the first product's Transaction toggle value
                          if (controller.user.value!.userProducts.isNotEmpty) {
                            var toggles =
                                controller.user.value!.userProducts[0]!.toggles;
                            toggles[0] =
                                Toggle(name: toggles[0].name, value: value);
                          }

                          // Update Firestore with the new toggle value
                          final userRef = FirebaseFirestore.instance
                              .collection('Users')
                              .doc(FirebaseAuth.instance.currentUser!.uid);
                          final List<Map<String, dynamic>> toggles = controller
                              .user.value!.userProducts[0]!.toggles
                              .map((toggle) => toggle.toMap())
                              .toList();
                          toggles[0]['value'] = value;
                          await userRef.update({
                            'userProducts.0.toggles': toggles,
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                const SizedBox(height: 56),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.transparent,
                        ),
                        child: const Text('กลับ'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => AddNewCard());
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.black,
                        ),
                        child: const Text(
                          'เพิ่มบัตร',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      }
    });
  }
}
