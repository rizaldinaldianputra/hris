import 'package:hris/models/overtime_shift_model.dart';

class Overtime {
  String? id;
  OvertimeShiftRequestModel? overtimeShiftRequest;
  DateTime? startShiftTime;
  DateTime? endShiftTime;
  dynamic compensation; // Sesuaikan dengan tipe data yang diharapkan
  String? workNote;
  dynamic manager; // Sesuaikan dengan tipe data yang diharapkan
  List<String>? files;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Overtime.blank();
  Overtime({
    required this.id,
    required this.overtimeShiftRequest,
    required this.startShiftTime,
    required this.endShiftTime,
    this.compensation,
    required this.workNote,
    this.manager,
    required this.files,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Fungsi untuk membuat instance dari JSON
  factory Overtime.fromJson(Map<String, dynamic> json) {
    return Overtime(
      id: json['id'],
      overtimeShiftRequest:
          OvertimeShiftRequestModel.fromJson(json['overtimeShiftRequest']),
      startShiftTime: DateTime.parse(json['startShiftTime']),
      endShiftTime: DateTime.parse(json['endShiftTime']),
      compensation: json['compensation'],
      workNote: json['workNote'],
      manager: json['manager'],
      files: List<String>.from(json['files']),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Fungsi untuk mengubah instance menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'overtimeShiftRequest': overtimeShiftRequest!.toJson(),
      'startShiftTime': startShiftTime!.toIso8601String(),
      'endShiftTime': endShiftTime!.toIso8601String(),
      'compensation': compensation,
      'workNote': workNote,
      'manager': manager,
      'files': files,
      'status': status,
      'createdAt': createdAt!.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
