import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/firebase_options.dart';
import 'package:poc_cimb/screen/notiSetting.dart';
import 'package:poc_cimb/screen/signinScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // getPages: [
      //   GetPage(name: '/', page: () => SigninScreen()),
      //   GetPage(name: '/Notisetting', page: () => NotiSettingMainScreen()),
      // ],
      builder: EasyLoading.init(),
      title: 'CIMB',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SigninScreen(),
    );
  }
}
