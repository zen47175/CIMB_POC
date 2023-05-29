// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:poc_cimb/widget/settingItem.dart';

// class ProductController extends GetxController {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

// // final String? productName = Get.arguments as String?;
//   String productName = '';

//   RxList<SettingItem> settings = <SettingItem>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     getProductSettings();
//   }

//   void setProductName(String name) {
//     productName = name;
//   }

//   Future<void> getProductSettings() async {
//     final User? firebaseUser = _auth.currentUser;
//     final querySnapshot = await _firestore
//         .collection('Users')
//         .doc(firebaseUser?.uid) // Replace with the appropriate user ID
//         .collection('userProducts')
//         .doc(productName)
//         .get();

//     if (querySnapshot.exists) {
//       final data = querySnapshot.data() as Map<String, dynamic>;

//       data.forEach((key, value) {
//         if (key != 'productName' && key != 'productDetails') {
//           final bool settingValue = value as bool;
//           settings.add(SettingItem(label: key, value: settingValue));
//         }
//       });
//     }
//   }

//   void updateSettingValue(int index, bool newValue) {
//     settings[index].value = newValue;
//     update(); // Notify GetX that the state has changed
//   }
// }
