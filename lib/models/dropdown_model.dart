class DropdownModel {
  final String key;
  final String value;

  DropdownModel({required this.key, required this.value});

  // Factory method to create an instance from JSON
  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    return DropdownModel(
      key: json['key'],
      value: json['value'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}
