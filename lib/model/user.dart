import 'package:poc_cimb/model/product.dart';

class AppUser {
  final String id;
  final String phone;
  final String pincode;
  final String lineUID;
  bool? notificationCenter;
  final List<Product> userProducts;

  AppUser({
    required this.id,
    required this.phone,
    required this.pincode,
    required this.lineUID,
    required this.notificationCenter,
    required this.userProducts,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phone': phone,
      'pincode': pincode,
      'lineUID': lineUID,
      'notificationCenter': notificationCenter,
      'userProducts': userProducts.map((product) => product.toMap()).toList(),
    };
  }

  factory AppUser.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('map cannot be null');
    }

    var productsList = map['userProducts'];
    if (productsList != null && productsList is! List<dynamic>) {
      throw ArgumentError('userProducts must be a List');
    }

    return AppUser(
      id: map['id'] ?? '',
      phone: map['phone'] ?? '',
      pincode: map['pincode'] ?? '',
      lineUID: map['lineUID'] ?? '',
      notificationCenter: map['notificationCenter'] ?? false,
      userProducts: (productsList as List<dynamic>?)
              ?.map((product) =>
                  Product.fromMap(product as Map<String, dynamic>?))
              .toList() ??
          [],
    );
  }
}
