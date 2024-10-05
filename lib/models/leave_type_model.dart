import 'package:uuid/uuid.dart';

class LeaveTypeModel {
  String? id;
  String? companyId;
  String? name;
  String? createdByUserId;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor
  LeaveTypeModel({
    String? id, // UUID field, if not provided, a new one will be generated
    required this.companyId, // Must be provided
    required this.name, // Must be provided
    required this.createdByUserId, // Must be provided
    DateTime? createdAt, // If not provided, current DateTime will be used
    DateTime? updatedAt, // If not provided, current DateTime will be used
  })  : id = id ?? const Uuid().v4(), // Generate a UUID if null
        createdAt = createdAt ?? DateTime.now(), // Default to current time
        updatedAt = updatedAt ?? DateTime.now(); // Default to current time

  // Factory method to create from JSON
  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      name: json['name'] as String,
      createdByUserId: json['created_by_user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
  LeaveTypeModel.blank();
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'created_by_user_id': createdByUserId,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }
}
