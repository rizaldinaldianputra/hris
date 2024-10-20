import 'package:hris/models/leave_type_model.dart';

class LeaveModel {
  String? id;
  DateTime? createdAt;
  String? date;
  List<String>? files;
  LeaveTypeModel? leaveType;
  String? startDate;
  String? endDate;
  String? reason;
  String? status;

  LeaveModel({
    required this.id,
    required this.createdAt,
    required this.date,
    required this.files,
    required this.startDate,
    required this.endDate,
    required this.leaveType,
    required this.reason,
    required this.status,
  });

  LeaveModel.blank();
  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      date: json['date'],
      files: List<String>.from(json['files']),
      leaveType: LeaveTypeModel.fromJson(json['leaveType']),
      reason: json['reason'],
      status: json['status'],
      startDate: json['startDate'],
      endDate: json['endDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt!.toIso8601String(),
      'date': date,
      'files': files,
      'leaveType': leaveType!.toJson(),
      'reason': reason,
      'endDate': endDate,
      'startDate': startDate,
      'status': status,
    };
  }
}
