class LeaveModel {
  String? id;
  String? companyId;
  String? employeeId;
  String? leaveTypeId;
  DateTime? startDate;
  DateTime? endDate;
  double? totalDays;
  String? status; // 'pending', 'approved', 'rejected'
  String? reason;
  String? managerId;
  DateTime? createdAt;
  DateTime? updatedAt;

  // Constructor
  LeaveModel({
    this.id,
    this.companyId,
    this.employeeId,
    this.leaveTypeId,
    this.startDate,
    this.endDate,
    this.totalDays,
    this.status,
    this.reason,
    this.managerId,
    this.createdAt,
    this.updatedAt,
  });

  // Named constructor for blank/default object
  LeaveModel.blank();

  // Factory method to create from JSON
  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'] as String?,
      companyId: json['company_id'] as String?,
      employeeId: json['employee_id'] as String?,
      leaveTypeId: json['leave_type_id'] as String?,
      startDate: DateTime.tryParse(json['start_date'] ?? ''),
      endDate: DateTime.tryParse(json['end_date'] ?? ''),
      totalDays: (json['total_days'] as num?)?.toDouble(),
      status: json['status'] as String?,
      reason: json['reason'] as String?,
      managerId: json['manager_id'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'employee_id': employeeId,
      'leave_type_id': leaveTypeId,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'total_days': totalDays,
      'status': status,
      'reason': reason,
      'manager_id': managerId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
