import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class AddNewCardController extends GetxController {
  RxList<Map<String, dynamic>> selectedProducts =
      RxList<Map<String, dynamic>>();
  RxList<Map<String, dynamic>> unselectedProducts =
      RxList<Map<String, dynamic>>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _user = Rx<AppUser?>(null);
  RxList<Map<String, dynamic>> confirmedProducts =
      RxList<Map<String, dynamic>>();

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

  Future<int> getSelectedProductsCount() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final usersRef = FirebaseFirestore.instance.collection('Users');

    if (firebaseUser != null) {
      final userDoc = await usersRef.doc(firebaseUser.uid).get();
      final userData = userDoc.data();

      if (userData != null) {
        final userProducts =
            List<Map<String, dynamic>>.from(userData['userProducts']);

        final selectedProductsCount =
            userProducts.where((product) => product['selected'] == true).length;

        return selectedProductsCount;
      } else {
        throw Exception('No user data found');
      }
    } else {
      throw Exception('No user signed in');
    }
  }

  bool isProductSelected(Map<String, dynamic> product) {
    // It checks if the product is in the selectedProducts list
    return selectedProducts.contains(product);
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
          final toggles =
              List<Map<String, dynamic>>.from(product['transactionType']);

          final updatedToggles = toggles.map((toggle) {
            if (toggle['name'] != toggleName) {
              return toggle;
            }

            return {'name': toggle['name'], 'value': newValue};
          }).toList();

          return {
            ...product,
            'transactionType': updatedToggles,
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

  Future<void> getUserDataFromSelected() async {
    final User? firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      try {
        AppUser user = await getUserData(firebaseUser.uid);

        print('User Products: ${user.userProducts}');

        // Initialize unselectedProducts and selectedProducts based on userProducts
        selectedProducts.clear();
        unselectedProducts.clear();

        user.userProducts.forEach((product) {
          // Note the use of dot notation to access 'selected'
          if (product.selected == true) {
            // Convert the 'Product' object to a Map and add to 'selectedProducts'
            selectedProducts.add(product.toMap());
          } else {
            // Convert the 'Product' object to a Map and add to 'unselectedProducts'
            unselectedProducts.add(product.toMap());
          }
        });

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

  Future<void> addToSelectedProducts(Map<String, dynamic> product) async {
    product['selected'] = true;

    // Remove the product from unselectedProducts if it exists
    unselectedProducts.removeWhere((p) => p == product);

    // Check if the product is already in selectedProducts
    if (!selectedProducts.contains(product)) {
      selectedProducts.add(product);
    }

    // Update Firestore
    await updateFirestore();

    update();
  }

  Future<void> removeFromSelectedProducts(Map<String, dynamic> product) async {
    try {
      product['selected'] = false;

      selectedProducts.removeWhere((p) => p['id'] == product['id']);

      if (!unselectedProducts.any((p) => p['id'] == product['id'])) {
        unselectedProducts.add(product);
      }

      // Update Firestore
      await updateFirestore();

      update();
    } catch (e) {
      print('Error in removeFromSelectedProducts: $e');
    }
  }

  Future<void> updateFirestore() async {
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
          // If the product is in selectedProducts, return a new product with 'selected' set to true
          if (selectedProducts.any(
              (selectedProduct) => selectedProduct['id'] == product['id'])) {
            return {
              ...product,
              'selected': true,
            };
          } else {
            return {
              ...product,
              'selected': false,
            };
          }
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

  Future<void> loadSelectedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedProductsData = prefs.getString('selectedProducts');
    if (selectedProductsData != null) {
      final selectedProductsList = List<Map<String, dynamic>>.from(
        selectedProductsData
            .replaceAll('[', '')
            .replaceAll(']', '')
            .split('},')
            .map((productData) => {
                  ...productData.split(',').map((kv) => kv.split(':')).fold({},
                      (acc, entry) {
                    acc[entry[0].trim().replaceAll('{', '')] = entry[1].trim();
                    return acc;
                  }),
                }),
      );
      selectedProducts.assignAll(selectedProductsList);
    }
  }

  void initSelectedProducts(List<Map<String, dynamic>> products) {
    for (var product in products) {
      addToSelectedProducts(product);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserDataFromSelected();
    loadSelectedProducts();

    update();
  }

  @override
  void onClose() {
    _user.close();
    _isLoading.close();
    super.onClose();
  }
}
