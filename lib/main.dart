import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_line_liff/flutter_line_liff.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:poc_cimb/firebase_options.dart';
import 'package:poc_cimb/model/authen.dart';
import 'package:poc_cimb/screen/registerScreen/signinScreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:poc_cimb/screen/smsSettingScreen.dart';

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
}

void main() async {
  await GetStorage.init();
  GetStorage box = GetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show a loading spinner while waiting for user authentication status
          } else if (snapshot.hasData && isSignedIn) {
            return SmsSettingScreen(); // Show SmsSettingScreen if user is logged in
          } else {
            return SigninScreen(); // Show SigninScreen if user is not logged in
          }
        },
      ),
      initialRoute: '/',
      // routes: {
      //   'home': (context) => isSignedIn ? SigninScreen() : SmsSettingScreen(),
      // },
      // getPages: [
      //   GetPage<SigninScreen>(name: '/Home', page: () => SigninScreen()),
      //   GetPage<NotiSettingMainScreen>(
      //       name: '/Notisetting', page: () => const NotiSettingMainScreen()),
      //   GetPage<AddNewCard>(name: '/AddNewCard', page: () => AddNewCard()),
      //   GetPage<NotiSettingMainScreen>(
      //       name: '/NotiScreen', page: () => const NotiSettingMainScreen()),
      //   GetPage<SmsCardSettingScreen>(
      //       name: '/SmsCardSettingScreen', page: () => SmsCardSettingScreen()),
      //   GetPage<NotificationCenterScreen>(
      //       name: '/NotiCenter', page: () => NotificationCenterScreen()),
      //   GetPage<AgreementAndPolicy>(
      //       name: '/AgreementAndPolicyScreen',
      //       page: () => AgreementAndPolicy()),
      //   GetPage<SmsSettingScreen>(
      //       name: '/NotiMainSetting', page: () => SmsSettingScreen()),
      // ],
      title: 'CIMB',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
