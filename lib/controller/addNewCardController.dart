import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/user.dart';

class AddNewCardController extends GetxController {
  RxList<Map<String, dynamic>> selectedProducts =
      RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> unselectedProducts =
      RxList<Map<String, dynamic>>();
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
      if (userProducts is List) {
        return List<Map<String, dynamic>>.from(userProducts);
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

  Future<void> updateToggle(
      String productId, String toggleName, bool newValue) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final usersRef = FirebaseFirestore.instance.collection('Users');

    if (firebaseUser != null) {
      final userDoc = await usersRef.doc(firebaseUser.uid).get();
      final userData = userDoc.data();

      if (userData != null) {
        // Assuming userProducts is a list of maps
        final userProducts =
            List<Map<String, dynamic>>.from(userData['userProducts']);

        final updatedProducts = userProducts.map((product) {
          if (product['id'] != productId) {
            return product;
          }

          // Assuming toggles is a list of maps
          final toggles = List<Map<String, dynamic>>.from(product['toggles']);

          final updatedToggles = toggles.map((toggle) {
            if (toggle['name'] != toggleName) {
              return toggle;
            }

            return {'name': toggle['name'], 'value': newValue};
          }).toList();

          return {
            ...product,
            'toggles': updatedToggles,
          };
        }).toList();

        await usersRef.doc(firebaseUser.uid).update({
          'userProducts': updatedProducts,
        });
      } else {
        throw Exception('No user data found');
      }
    } else {
      throw Exception('No user signed in');
    }
  }

  void _getUserData() async {
    final User? firebaseUser = _auth.currentUser;
    print(firebaseUser?.phoneNumber.toString());
    if (firebaseUser != null) {
      try {
        AppUser user = await getUserData(firebaseUser.uid);

        print('User Products: ${user.userProducts}');

        // Initialize unselectedProducts with userProducts
        unselectedProducts.assignAll(List<Map<String, dynamic>>.from(
            user.userProducts.map((product) => product.toMap())));

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
    unselectedProducts.removeWhere((p) => p == product);
    update();
  }

  void removeFromSelectedProducts(Map<String, dynamic> product) {
    selectedProducts.removeWhere((p) => p == product);
    unselectedProducts.add(product);
    update();
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
