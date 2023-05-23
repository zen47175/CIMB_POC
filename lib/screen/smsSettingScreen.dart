import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/controller/addNewCardController.dart';
import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/screen/notificationSettingScreen.dart';
import 'package:poc_cimb/screen/productSetting.dart';
import 'package:poc_cimb/widget/confirmButton.dart';
import 'package:poc_cimb/widget/creditcard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/mainTitle.dart';

class SmsSettingScreen extends StatelessWidget {
  final AddNewCardController controller = Get.put(AddNewCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: MainTitle(
                text: 'ตั้งค่าการแจ้งเตือนผลิตภัณฑ์',
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 1,
              color: const Color.fromRGBO(229, 229, 229, 1),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    Get.to(() => NotificationCenterScreen());
                  },
                ),
              ),
            ),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.selectedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = controller.selectedProducts[index];
                  return CreditCard(
                    isToggle: true,
                    cardName: product['productName'],
                    cardDetails: product['productDetails'],
                    onTap: () {
                      Get.to(() => ProductSettingScreen(),
                          arguments: product['productName']);
                    },
                  );
                },
              ),
            ),
            Container(
              height: 1,
              color: const Color.fromRGBO(229, 229, 229, 1),
            ),
            const SizedBox(height: 40),
            ConfirmButton(
              mainText: 'เพิ่มบัตร',
              onPressed: () {
                Get.to(() => AddNewCard());
              },
              size: ConfirmButtonSize.full,
            ),
          ],
        ),
      ),
    );
  }
}
