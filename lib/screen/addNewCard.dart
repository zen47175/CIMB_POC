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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = kToolbarHeight;

    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(
        children: [
          Container(
            height: screenHeight * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
            ),
            child: MainTitle(
              text: 'เพิ่มผลิตภัณฑ์เพื่อเริ่มต้นการใช้งาน',
              fontSize: screenWidth * 0.04,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Color.fromRGBO(51, 55, 57, 0.1),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                'บัตรเครดิต',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.036,
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // make sure there is data and at least one product
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  final product = snapshot.data![0];
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
                } else {
                  // return a widget or some kind of message when there is no product data
                  return Text('No products found');
                }
              }
            },
          ),
          SizedBox(
            height: screenHeight * 0.04,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Color.fromRGBO(51, 55, 57, 0.1),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Text(
                'ผลิตภัณฑ์ที่เกี่ยวข้องกับคุณ',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.036,
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
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
            print(addNewCardController.selectedProducts);
            // addNewCardController.selectedProducts.clear();
          },
        ),
      ),
    );
  }
}
