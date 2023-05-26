// import 'package:get/get.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:poc_cimb/model/user.dart';
// class UserController extends GetxController {
//   Rx<AppUser> user = Rx<AppUser>();

//   void getUserData(String uid) async {
//     final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Users').doc(uid).get();
//     user.value = AppUser.fromMap(doc.data());
//   }
// }
