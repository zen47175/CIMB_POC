import 'package:poc_cimb/model/toggle.dart';

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

  factory Product.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('map cannot be null');
    }

    var togglesList = map['toggles'];
    if (togglesList != null && togglesList is! List<dynamic>) {
      throw ArgumentError('toggles must be a List');
    }

    return Product(
      id: map['id'] ?? '',
      productName: map['productName'] ?? '',
      productDetails: map['productDetails'] ?? '',
      type: map['type'] ?? '',
      toggles: (togglesList as List<dynamic>?)
              ?.map((toggle) => Toggle.fromMap(toggle as Map<String, dynamic>?))
              .toList() ??
          [],
    );
  }
}
