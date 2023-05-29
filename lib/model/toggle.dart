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

  factory Toggle.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      throw ArgumentError('map cannot be null');
    }
    return Toggle(
      name: map['name'] ?? '',
      value: map['value'] ?? false,
    );
  }
}
