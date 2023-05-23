import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/addNewCard.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/widget/mainTitle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SmsCardSettingScreen extends StatefulWidget {
  const SmsCardSettingScreen({super.key});

  @override
  State<SmsCardSettingScreen> createState() => _SmsCardSettingScreenState();
}

class _SmsCardSettingScreenState extends State<SmsCardSettingScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  AppUser? _user;

  bool _isLoading = true;
  bool _isSwitched = false;
  bool notificationCenter = false;
  @override
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<AppUser> getUserData(String uid) async {
    final User? firebaseUser = _auth.currentUser;
    DocumentSnapshot userDoc =
        await _firestore.collection('Users').doc(firebaseUser?.uid).get();

    if (userDoc.exists) {
      return AppUser.fromMap(userDoc.data() as Map<String, dynamic>);
    } else {
      throw Exception('User not found');
    }
  }

  void _getUserData() async {
    final User? firebaseUser = _auth.currentUser;
    print(firebaseUser?.phoneNumber.toString());
    if (firebaseUser != null) {
      try {
        AppUser user = await getUserData(firebaseUser.uid);

        print('User Products: ${user.userProducts}');

        setState(() {
          _user = user;
          _isLoading = false;
        });
      } catch (e) {
        print(e);
      }
    } else {
      // Handle the case where the user is not signed in.
      print('No user signed in');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      ); // Display a loading spinner while data is being fetched
    }

    if (_user == null) {
      return Center(
        child: Text("No user data available"),
      ); // Display a message if no user data was fetched
    }
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: MainTitle(
                  text: 'ตั้งค่าบริการการแจ้งเตือนผ่าน SMS',
                  fontSize: 17,
                )),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height:
                      1.0, // H: 0 pt (A line height of 0 pt would be invisible, so we use 1 pt)
                  width: 316, // W: 316 pt
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1.0, // Width: 1 pt
                        color: Color.fromRGBO(
                            229, 229, 229, 1.0), // rgba 0.9, 0.9, 0.9, 1.0
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: 328,
              height: 210,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Creditcard.png'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _user?.userProducts?['Product1']?['productName'] ?? '',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Color(0xFF790009),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _user?.userProducts?['Product1']?['productDetails'] ?? '',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '(บัตรหลัก)',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ยอดการใช้จ่ายผ่านบัตร',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    CupertinoSwitch(
                      value: _user!.notificationCenter ?? notificationCenter,
                      activeColor: Colors.black,
                      onChanged: (bool value) async {
                        setState(() {
                          _user!.notificationCenter = value;
                        });

                        // Update Firestore with the new notificationCenter value
                        final userRef = _firestore
                            .collection('Users')
                            .doc(_auth.currentUser!.uid);
                        await userRef.update({
                          'userProducts.Product1.Transaction': value,
                        });
                      },
                    ),
                  ]),
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            const SizedBox(height: 56),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.transparent,
                    ),
                    child: const Text('กลับ'),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => AddNewCard());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'เพิ่มบัตร',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
