import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poc_cimb/controller/addNewCardController.dart';
import 'package:poc_cimb/controller/productController.dart';
import 'package:poc_cimb/controller/smsCardSettingController.dart';
import 'package:poc_cimb/firebase_options.dart';
import 'package:poc_cimb/model/authen.dart';
import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/screen/notificationSettingScreen.dart';
import 'package:poc_cimb/screen/registerScreen/agreementAndPolicyScreen.dart';
import 'package:poc_cimb/screen/registerScreen/notiSetting.dart';
import 'package:poc_cimb/screen/registerScreen/otpScreen.dart';
import 'package:poc_cimb/screen/registerScreen/signinScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:poc_cimb/screen/smsSettingScreen.dart';

import 'screen/smsCardSettingScreen.dart';

Future<void> initializeApp() async {
  String LineID = '1661241096-NAzwM1wp';
  FlutterLineLiff().init(
    config: Config(liffId: LineID),
    successCallback: () {
      log('LIFF init success.');
    },
    errorCallback: (error) {
      log('LIFF init error: ${error.name}, ${error.message}, ${error.stack}');
    },
  );
  await GetStorage.init();
  GetStorage box = GetStorage();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final addNewCardController = Get.put(AddNewCardController());
  final smsCardSettingController = Get.put(SmsCardSettingController());
  final productController = Get.put(ProductController());

  void configEasyLoading() {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.light
      ..dismissOnTap = false
      ..userInteractions = false
      ..indicatorWidget = const CircularProgressIndicator(
        color: Colors.red,
        strokeWidth: 2,
      );
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialRoute: '/Home',
      getPages: [
        GetPage<SigninScreen>(name: '/Home', page: () => SigninScreen()),
        GetPage<NotiSettingMainScreen>(
            name: '/Notisetting', page: () => const NotiSettingMainScreen()),
        GetPage<AddNewCard>(name: '/AddNewCard', page: () => AddNewCard()),
        GetPage<NotiSettingMainScreen>(
            name: '/NotiScreen', page: () => const NotiSettingMainScreen()),
        GetPage<SmsCardSettingScreen>(
            name: '/SmsCardSettingScreen', page: () => SmsCardSettingScreen()),
        GetPage<NotificationCenterScreen>(
            name: '/NotiCenter', page: () => NotificationCenterScreen()),
        GetPage<AgreementAndPolicy>(
            name: '/AgreementAndPolicyScreen',
            page: () => AgreementAndPolicy()),
        GetPage<SmsSettingScreen>(
            name: '/NotiMainSetting', page: () => SmsSettingScreen()),
      ],
      title: 'CIMB',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
