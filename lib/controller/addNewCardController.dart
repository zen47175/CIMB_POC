import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class AddNewCardController extends GetxController {
  final selectedProducts = <Map<String, dynamic>>[].obs;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _user = Rx<AppUser?>(null);
  final _isLoading = true.obs;

  AppUser? get user => _user.value;
  bool get isLoading => _isLoading.value;

  Future<List<Map<String, dynamic>>> loadUserProducts() async {
    final _auth = FirebaseAuth.instance;
    final User? firebaseUser = _auth.currentUser;
    final userRef =
        FirebaseFirestore.instance.collection('Users').doc(firebaseUser?.uid);
    final snapshot = await userRef.get();
    if (snapshot.exists) {
      final userProducts = snapshot.data()?['userProducts'];
      if (userProducts is Map<String, dynamic>) {
        return userProducts.entries
            .map<Map<String, dynamic>>(
                (entry) => entry.value as Map<String, dynamic>)
            .toList();
      } else {
        throw Exception('Invalid userProducts data type');
      }
    } else {
      throw Exception('User does not exist');
    }
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
        // if (selectedProducts.isEmpty) {
        //   final loadedProducts = await loadUserProducts();
        //   selectedProducts.addAll(loadedProducts);
        // }
        _user.value = user;
        _isLoading.value = false;
      } catch (e) {
        print(e);
      }
    } else {
      // Handle the case where the user is not signed in.
      print('No user signed in');
      _isLoading.value = false;
    }
  }

  void addToSelectedProducts(Map<String, dynamic> product) {
    selectedProducts.add(product);
  }

  void removeFromSelectedProducts(Map<String, dynamic> product) {
    selectedProducts.remove(product);
  }

  @override
  void onInit() {
    super.onInit();
    _getUserData();
  }

  @override
  void onClose() {
    _user.close();
    _isLoading.close();
    super.onClose();
  }
}
