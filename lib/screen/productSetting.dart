// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:poc_cimb/widget/customAppbar.dart';
// import 'package:poc_cimb/widget/mainTitle.dart';
// import 'package:poc_cimb/widget/settingListItem.dart';
// import 'package:poc_cimb/widget/settingItem.dart';

// import '../controller/productController.dart'; // Import the correct SettingItem class

// class ProductSettingScreen extends StatelessWidget {
//   final ProductController _productController = Get.put(ProductController());

//   @override
//   Widget build(BuildContext context) {
//     final productName = _productController.productName;
//     return Scaffold(
//       appBar: CustomAppBar(),
//       body: Column(
//         children: [
//           const SizedBox(height: 40),
//           MainTitle(
//             text: 'ประเภทการตั้งค่าแจ้งเตือน',
//             fontSize: 17,
//           ),
//           const SizedBox(height: 24),
//           Container(
//             height: 1,
//             color: const Color.fromRGBO(229, 229, 229, 1),
//           ),
//           const SizedBox(height: 40),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30),
//             child: Text(
//               'ตั้งค่าการแจ้งเตือนผลิตภัณฑ์',
//               style: TextStyle(fontSize: 17),
//             ),
//           ),
//           const SizedBox(height: 24),
//           Container(
//             height: 1,
//             color: const Color.fromRGBO(229, 229, 229, 1),
//           ),
//           const SizedBox(height: 24),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: GetBuilder<ProductController>(
//                 builder: (controller) => ListView.separated(
//                   itemCount: controller.settings.length,
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 16.0),
//                   itemBuilder: (context, index) {
//                     final setting = controller.settings[index];
//                     return SettingListItem(
//                       setting: setting,
//                       onChanged: (newValue) =>
//                           controller.updateSettingValue(index, newValue),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
