import 'package:flutter/material.dart';

class Attendance {
  String? id;
  String? employeeId;
  String? employeeShiftId;
  DateTime? date;
  TimeOfDay? clockInTime;
  String? clockInImage;
  String? clockInLat;
  String? clockInLong;
  TimeOfDay? clockOutTime;
  String? clockOutImage;
  String? clockOutLat;
  String? clockOutLong;
  String? clockInPresentStatus;
  String? clockInRangeStatus;
  String? clockOutRangeStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  Attendance({
    this.id,
    this.employeeId,
    this.employeeShiftId,
    this.date,
    this.clockInTime,
    this.clockInImage,
    this.clockInLat,
    this.clockInLong,
    this.clockOutTime,
    this.clockOutImage,
    this.clockOutLat,
    this.clockOutLong,
    this.clockInPresentStatus,
    this.clockInRangeStatus,
    this.clockOutRangeStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      employeeId: json['employee_id'],
      employeeShiftId: json['employee_shift_id'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      clockInTime: json['clockin_time'] != null
          ? TimeOfDay.fromDateTime(DateTime.parse(json['clockin_time']))
          : null,
      clockInImage: json['clockin_image'],
      clockInLat: json['clockin_lat'],
      clockInLong: json['clockin_long'],
      clockOutTime: json['clockout_time'] != null
          ? TimeOfDay.fromDateTime(DateTime.parse(json['clockout_time']))
          : null,
      clockOutImage: json['clockout_image'],
      clockOutLat: json['clockout_lat'],
      clockOutLong: json['clockout_long'],
      clockInPresentStatus: json['clockin_present_status'],
      clockInRangeStatus: json['clockin_range_status'],
      clockOutRangeStatus: json['clockout_range_status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'employee_shift_id': employeeShiftId,
      'date': date?.toIso8601String(),
      'clockin_time': clockInTime != null
          ? DateTime(0, 0, 0, clockInTime!.hour, clockInTime!.minute)
              .toIso8601String()
          : null,
      'clockin_image': clockInImage,
      'clockin_lat': clockInLat,
      'clockin_long': clockInLong,
      'clockout_time': clockOutTime != null
          ? DateTime(0, 0, 0, clockOutTime!.hour, clockOutTime!.minute)
              .toIso8601String()
          : null,
      'clockout_image': clockOutImage,
      'clockout_lat': clockOutLat,
      'clockout_long': clockOutLong,
      'clockin_present_status': clockInPresentStatus,
      'clockin_range_status': clockInRangeStatus,
      'clockout_range_status': clockOutRangeStatus,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Attendance.blank();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Attendance && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
