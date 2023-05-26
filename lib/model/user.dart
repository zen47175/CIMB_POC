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

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] ?? '',
      phone: map['phone'] ?? '',
      pincode: map['pincode'] ?? '',
      lineUID: map['lineUID'] ?? '',
      notificationCenter: map['notificationCenter'] ?? false,
      userProducts: (map['userProducts'] as List<dynamic>?)
              ?.map((product) => Product.fromMap(product))
              .toList() ??
          [],
    );
  }
}

class Product {
  final String id; // Add this
  final String productName;
  final String productDetails;
  final String type;
  final List<Toggle> toggles;

  Product({
    required this.id, // And this
    required this.productName,
    required this.productDetails,
    required this.type,
    required this.toggles,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // And this
      'productName': productName,
      'productDetails': productDetails,
      'type': type,
      'toggles': toggles.map((toggle) => toggle.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '', // And this
      productName: map['productName'] ?? '',
      productDetails: map['productDetails'] ?? '',
      type: map['type'] ?? '',
      toggles: (map['toggles'] as List<dynamic>?)
              ?.map((toggle) => Toggle.fromMap(toggle))
              .toList() ??
          [],
    );
  }
}

class Toggle {
  final String name;
  final bool value;

  Toggle({required this.name, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'value': value,
    };
  }

  factory Toggle.fromMap(Map<String, dynamic> map) {
    return Toggle(
      name: map['name'] ?? '',
      value: map['value'] ?? false,
    );
  }
}
