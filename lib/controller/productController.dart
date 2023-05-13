import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  void addProduct(
      String userId, String productId, bool notificationEnabled) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    var userDoc = await users.doc(userId).get();

    if (userDoc.exists) {
      List<dynamic> products =
          (userDoc.data() as Map<String, dynamic>)['products'] ?? [];

      products.add({
        'productId': productId,
        'notificationEnabled': notificationEnabled,
      });

      users.doc(userId).update({
        'products': products,
      });
    } else {
      print('User does not exist');
    }
  }

  void getProducts(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    var userDoc = await users.doc(userId).get();

    if (userDoc.exists) {
      List<dynamic> products =
          (userDoc.data() as Map<String, dynamic>)['products'] ?? [];

      for (var product in products) {
        print('Product ID: ${product['productId']}');
        print('Notification Enabled: ${product['notificationEnabled']}');
      }
    } else {
      print('User does not exist');
    }
  }
}
