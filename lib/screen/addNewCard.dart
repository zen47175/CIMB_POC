import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poc_cimb/controller/addNewCardController.dart';
import 'package:poc_cimb/model/authen.dart';
import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/confirmScreen.dart';
import 'package:poc_cimb/widget/checklistCreditCard.dart';
import 'package:poc_cimb/widget/creditcard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customButtombar.dart';
import 'package:poc_cimb/widget/mainTitle.dart';

class AddNewCard extends StatelessWidget {
  final AddNewCardController addNewCardController =
      Get.put(AddNewCardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(
        () => ListView(
          children: [
            Container(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 28.0,
              ),
              child: MainTitle(
                text: 'เพิ่มผลิตภัณฑ์เพื่อเริ่มต้นการใช้งาน',
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromRGBO(51, 55, 57, 0.1),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    8.0), // adjust this padding as per your needs
                child: Text(
                  'บัตรเครดิต',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            CheckListCreditCard(
              isToggle: false,
              isSelectable: true,
              cardName: addNewCardController.user?.userProducts['Product1']
                      ?['productName'] ??
                  '',
              cardDetails: addNewCardController.user?.userProducts['Product1']
                      ?['productDetails'] ??
                  '',
              onSelected: (isSelected) {
                if (isSelected) {
                  addNewCardController.addToSelectedProducts(
                      addNewCardController.user?.userProducts['Product1'] ??
                          {});
                } else {
                  addNewCardController.removeFromSelectedProducts(
                      addNewCardController.user?.userProducts['Product1'] ??
                          {});
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                color: Color.fromRGBO(51, 55, 57, 0.1),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                    8.0), // adjust this padding as per your needs
                child: Text(
                  'ผลิตภัณฑ์ที่เกี่ยวข้องกับคุณ',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: addNewCardController.loadUserProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (snapshot.data?.length ?? 0) - 1,
                    itemBuilder: (BuildContext context, int index) {
                      final product = snapshot.data![index + 1];
                      return CheckListCreditCard(
                        isSelectable: true,
                        isToggle: false,
                        cardName: product['productName'],
                        cardDetails: product['productDetails'],
                        onSelected: (isSelected) {
                          if (isSelected) {
                            addNewCardController.addToSelectedProducts(product);
                          } else {
                            addNewCardController
                                .removeFromSelectedProducts(product);
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              offset: Offset(0, -4),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: CustomBottomBar(
          onAddButtonPressed: null,
          onConfirmButtonPressed: () {
            signIn();
            Get.to(() => ConfirmScreen(
                  selectedProducts: addNewCardController.selectedProducts,
                ));

            // addNewCardController.selectedProducts.clear();
          },
        ),
      ),
    );
  }
}
