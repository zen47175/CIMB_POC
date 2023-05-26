import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:poc_cimb/model/user.dart';

class SmsCardSettingController extends GetxController {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Rx<AppUser?> user = Rx<AppUser?>(null);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final User? firebaseUser = _auth.currentUser;
    print(firebaseUser?.phoneNumber.toString());
    if (firebaseUser != null) {
      try {
        AppUser userData = await getUserData(firebaseUser.uid);
        print('User Products: ${userData.userProducts}');
        user.value = userData;
        isLoading.value = false;
      } catch (e) {
        print(e);
        isLoading.value = false;
      }
    } else {
      print('No user signed in');
      isLoading.value = false;
    }
  }

  Future<AppUser> getUserData(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('Users').doc(uid).get();

    if (userDoc.exists) {
      return AppUser.fromMap(userDoc.data() as Map<String, dynamic>);
    } else {
      throw Exception('User not found');
    }
  }
}
