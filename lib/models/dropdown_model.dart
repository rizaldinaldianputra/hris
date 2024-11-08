class DropdownModel {
  String? key;
  String? value;

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

  DropdownModel.blank();
}

class DropdownModelYears {
  int? key;
  int? value;

  DropdownModelYears({required this.key, required this.value});

  // Factory method to create an instance from JSON
  factory DropdownModelYears.fromJson(Map<String, dynamic> json) {
    return DropdownModelYears(
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

  DropdownModelYears.blank();
}
