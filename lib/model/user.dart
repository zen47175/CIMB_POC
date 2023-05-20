class AppUser {
  final String id;
  final String phone;
  final String pincode;
  final String lineUID;
  late final bool notificationCenter;
  final Map<String, Map<String, dynamic>> userProducts;

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
      'userProducts': userProducts,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'] ?? '',
      phone: map['phone'] ?? '',
      pincode: map['pincode'] ?? '',
      lineUID: map['lineUID'] ?? '',
      notificationCenter: map['notificationCenter'] ?? false,
      userProducts: (map['userProducts'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, Map<String, dynamic>.from(value)),
          ) ??
          {},
    );
  }
}
