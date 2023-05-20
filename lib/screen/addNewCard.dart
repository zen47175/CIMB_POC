// ignore: file_names
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poc_cimb/screen/confirmScreen.dart';
import 'package:poc_cimb/widget/checklistCreditCard.dart';
import 'package:poc_cimb/widget/creditcard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customButtombar.dart';
import 'package:poc_cimb/widget/mainTitle.dart';
import 'package:get/get.dart';

class AddNewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView(children: [
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
            )),
        const SizedBox(
          height: 20,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromRGBO(51, 55, 57, 0.1),
          ),
          child: Padding(
            padding:
                EdgeInsets.all(8.0), // adjust this padding as per your needs
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
          child: Container(
            width: 352,
            height: 64.38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE5E5E5),
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 57.11,
                  height: 35.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Creditcard.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(width: 10), // adjust as needed
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "บัตรเครดิต CIMB Thai Debit Card",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 8,
                        height: 2.07,
                      ),
                    ),
                    Text(
                      "7733-38xx-xxxx-9080",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 8,
                          height: 2.07,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "บัตรหลัก",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 8,
                        height: 2.07,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const Spacer(), // pushes the next child to the end
                const Icon(
                  Icons.more_vert, // replace with actual icon
                  color: Color(0xFFD9D9D9),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const CreditCard(
          isToggle: false,
        ),
        CheckListCreditCard(
          isSelectable: true,
        )
      ]),
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
                Get.to(() => const ConfirmScreen());
              })),
    );
  }
}
