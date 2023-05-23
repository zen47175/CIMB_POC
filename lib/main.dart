import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/firebase_options.dart';
import 'package:poc_cimb/model/authen.dart';
import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/screen/notificationSettingScreen.dart';
import 'package:poc_cimb/screen/registerScreen/notiSetting.dart';
import 'package:poc_cimb/screen/registerScreen/signinScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:poc_cimb/screen/smsCardSettingScreen.dart';
import 'package:poc_cimb/screen/smsSettingScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> selectedProducts;
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        initialRoute: '/Home',
        getPages: [
          GetPage(name: '/Home', page: () => SigninScreen()),
          GetPage(
              name: '/Notisetting', page: () => const NotiSettingMainScreen()),
          GetPage(name: '/AddNewCard', page: () => AddNewCard()), // add this
          GetPage(
              name: '/NotiMainSetting',
              page: () => SmsSettingScreen()), // add this
          GetPage(
              name: '/NotiScreen',
              page: () => NotiSettingMainScreen()), // add this

          GetPage(
              name: '/SmsCardSettingScreen',
              page: () => const SmsCardSettingScreen()),
          GetPage(name: '/NotiCenter', page: () => NotificationCenterScreen()),
        ],
        title: 'CIMB',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: isSignedIn ? SigninScreen() : SmsSettingScreen());
  }
}
