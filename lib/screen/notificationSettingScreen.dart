import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:poc_cimb/model/authen.dart';
import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/widget/confirmButton.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customButtombar.dart';
import 'package:poc_cimb/widget/mainTitle.dart';
import 'package:poc_cimb/widget/notiItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationCenterScreen extends StatefulWidget {
  @override
  _NotificationCenterScreenState createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  bool notificationCenter = false; // Toggle value

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;

    AppUser? _user;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            MainTitle(
              text: 'ตั้งค่าการแจ้งเตือน',
              fontSize: 17,
            ),
            const SizedBox(height: 24),
            Container(
              height: 1,
              color: const Color.fromRGBO(229, 229, 229, 1),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  NotificationItem(
                    text: 'ตั้งค่าแจ้งเตือนผลิตภัณฑ์ทั้งหมด',
                    isToggled: notificationCenter,
                    onChanged: (value) {
                      setState(() {
                        notificationCenter = value;
                      });
                      // Update Firestore with the new notificationCenter value
                      final userRef = _firestore
                          .collection('Users')
                          .doc(_auth.currentUser!.uid);
                      userRef.update({
                        'notificationCenter': value,
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: ConfirmButton(
                      mainText: 'ยกเลิกการเชื่อมต่อ',
                      onPressed: () {
                        signOut();
                      },
                      size: ConfirmButtonSize.mid,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
