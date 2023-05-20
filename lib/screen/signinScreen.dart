import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/model/user.dart';
import 'package:poc_cimb/screen/otpScreen.dart';
import 'package:poc_cimb/widget/customAppbar.dart';
import 'package:poc_cimb/widget/customField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _isValidInput = false;
  @override
  void initState() {
    super.initState();
    _idController.addListener(_validateInput);
    _phoneController.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {
      _isValidInput =
          _idController.text.length == 13 && _phoneController.text.length == 10;
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'กรุณากรอกข้อมูลเพื่อลงทะเบียนกับ CIMB Thailand',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Container(
                width: 328,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromRGBO(
                        229, 229, 229, 1), // RGB(0.898, 0.898, 0.898)
                    width: 1,
                  ),
                ),
                child: CustomFormField(
                  hintText: 'เลขบัตรประชาชน',
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(
                        13), // limit input to 4 digits
                    FilteringTextInputFormatter.digitsOnly, // allow only digits
                  ],
                )),
            const SizedBox(height: 10),
            Container(
                width: 328,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromRGBO(
                        229, 229, 229, 1), // RGB(0.898, 0.898, 0.898)
                    width: 1,
                  ),
                ),
                child: CustomFormField(
                  hintText: 'เบอร์โทรศัพท์',
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(
                        10), // limit input to 4 digits
                    FilteringTextInputFormatter.digitsOnly, // allow only digits
                  ],
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Row(children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('ยกเลิก'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[300],
                        onPrimary: Colors.black, // text color
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // border radius
                        ),
                      ),
                    ),
                    const SizedBox(width: 12), // Space between the two buttons
                    ElevatedButton(
                      onPressed: _isValidInput
                          ? () async {
                              // Check if a user with the same id or phone already exists
                              // final QuerySnapshot idResult = await _firestore
                              //     .collection('Users')
                              //     .where('id', isEqualTo: _idController.text)
                              //     .get();

                              // final QuerySnapshot phoneResult = await _firestore
                              //     .collection('Users')
                              //     .where('phone',
                              //         isEqualTo: _phoneController.text)
                              //     .get();

                              // if (idResult.docs.isEmpty &&
                              //     phoneResult.docs.isEmpty)
                              //TODO don't for get to uncode check id
                              if (_isValidInput) {
                                // If no user exists with the id or phone, then create a new one
                                final ConfirmationResult confirmationResult =
                                    await _auth.signInWithPhoneNumber(
                                        '+66${_phoneController.text}');

                                Get.to(() => OtpScreen(
                                    confirmationResult: confirmationResult));

                                // Create new user instance
                                AppUser newUser = AppUser(
                                  id: _idController.text,
                                  phone: _phoneController.text,
                                  pincode: '',
                                  lineUID: '',
                                  notificationCenter: false,
                                  userProducts: {
                                    'autoID1': {
                                      'productName':
                                          'บัตรเครดิต CIMB Thai Credit Card',
                                      'productDetails': '7733-38xx-xxxx-9080',
                                      'productNotifications': false,
                                    },
                                    'autoID2': {
                                      'productName':
                                          'บัตรเดบิต CIMB Thai Debit Card (Banking Account)',
                                      'productDetails': '7733-38xx-xxxx-2243',
                                      'productNotifications': false,
                                    },
                                  },
                                );
                                await _firestore
                                    .collection('Users')
                                    .doc(newUser.id)
                                    .set(newUser.toMap());
                              } else {
                                // If a user exists with either the id or phone, show a popup
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'A user with this ID or phone number already exists.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            _isValidInput ? Colors.white : Colors.black,
                        backgroundColor:
                            _isValidInput ? Colors.black : Colors.grey[300],
                      ),
                      child: const Text('ขอรหัส otp'),
                    ),
                  ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
