class OvertimeShiftRequestModel {
  String id;
  String name;

  OvertimeShiftRequestModel({
    required this.id,
    required this.name,
  });

  factory OvertimeShiftRequestModel.fromJson(Map<String, dynamic> json) {
    return OvertimeShiftRequestModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
