import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/controller/addNewCardController.dart';

import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/screen/settings.dart';

import 'package:poc_cimb/widget/confirmButton.dart';
import 'package:poc_cimb/widget/creditcard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/mainTitle.dart';

class SmsSettingScreen extends StatelessWidget {
  final AddNewCardController _controller = Get.put(AddNewCardController());

  Widget build(BuildContext context) {
    _controller.updateFirestore();

    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: MainTitle(
                      text: 'ตั้งค่าการแจ้งเตือนผลิตภัณฑ์',
                      fontSize: 17,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {
                          Get.to((() => SettingsScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                height: 1,
                color: const Color.fromRGBO(229, 229, 229, 1),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _controller
                    .loadUserProducts(), // Fetch the data from Firebase
                builder: (BuildContext context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show a loading spinner while waiting for data
                  } else {
                    if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}'); // Show error message if there is any error
                    } else {
                      var selectedProducts = snapshot.data!
                          .where((product) => product['selected'] == true)
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: selectedProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = selectedProducts[index];
                          print('Product: $product');
                          return CreditCard(
                            cardName: product['productName'] ?? '',
                            cardDetails: product['productDetails'] ?? '',
                            toggles: product['toggles'] != null
                                ? List<Map<String, dynamic>>.from(
                                    product['toggles'])
                                : [],
                            productId: product['id'] ?? '',
                          );
                        },
                      );
                    }
                  }
                },
              ),
              Container(
                height: 1,
                color: const Color.fromRGBO(229, 229, 229, 1),
              ),
              const SizedBox(height: 40),
              // ConfirmButton(
              //   mainText: 'เพิ่มบัตร',
              //   onPressed: () {
              //     Get.to(() => AddNewCard());
              //   },
              //   size: ConfirmButtonSize.full,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
