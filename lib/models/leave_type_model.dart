class LeaveTypeModel {
  final String id;
  final String companyId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdByUserId;

  LeaveTypeModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.createdByUserId,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      id: json['id'],
      companyId: json['companyId'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      createdByUserId: json['createdByUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'createdByUserId': createdByUserId,
    };
  }
}
