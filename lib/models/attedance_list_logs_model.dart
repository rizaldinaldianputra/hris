class AttendanceListLogsModel {
  final String id;
  final String employeeId;
  final String employeeShiftId;
  final String date;
  final String? clockinTime;
  final String? clockinImage;
  final double? clockinLat;
  final double? clockinLong;
  final String? clockoutTime;
  final String? clockoutImage;
  final double? clockoutLat;
  final double? clockoutLong;
  final String? clockinRangeStatus;
  final String? clockoutRangeStatus;
  final String clockinStatus;
  final String? totalWorkingHours;
  final String? clockoutStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceListLogsModel({
    required this.id,
    required this.employeeId,
    required this.employeeShiftId,
    required this.date,
    this.clockinTime,
    this.clockinImage,
    this.clockinLat,
    this.clockinLong,
    this.clockoutTime,
    this.clockoutImage,
    this.clockoutLat,
    this.clockoutLong,
    this.clockinRangeStatus,
    this.clockoutRangeStatus,
    required this.clockinStatus,
    this.totalWorkingHours,
    this.clockoutStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method untuk membuat instance dari JSON
  factory AttendanceListLogsModel.fromJson(Map<String, dynamic> json) {
    return AttendanceListLogsModel(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      employeeShiftId: json['employeeShiftId'] as String,
      date: json['date'] as String,
      clockinTime: json['clockinTime'] as String?,
      clockinImage: json['clockinImage'] as String?,
      clockinLat: (json['clockinLat'] as num?)?.toDouble(),
      clockinLong: (json['clockinLong'] as num?)?.toDouble(),
      clockoutTime: json['clockoutTime'] as String?,
      clockoutImage: json['clockoutImage'] as String?,
      clockoutLat: (json['clockoutLat'] as num?)?.toDouble(),
      clockoutLong: (json['clockoutLong'] as num?)?.toDouble(),
      clockinRangeStatus: json['clockinRangeStatus'] as String?,
      clockoutRangeStatus: json['clockoutRangeStatus'] as String?,
      clockinStatus: json['clockinStatus'] as String,
      totalWorkingHours: json['totalWorkingHours'] as String?,
      clockoutStatus: json['clockoutStatus'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Method untuk mengubah instance menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeShiftId': employeeShiftId,
      'date': date,
      'clockinTime': clockinTime,
      'clockinImage': clockinImage,
      'clockinLat': clockinLat,
      'clockinLong': clockinLong,
      'clockoutTime': clockoutTime,
      'clockoutImage': clockoutImage,
      'clockoutLat': clockoutLat,
      'clockoutLong': clockoutLong,
      'clockinRangeStatus': clockinRangeStatus,
      'clockoutRangeStatus': clockoutRangeStatus,
      'clockinStatus': clockinStatus,
      'totalWorkingHours': totalWorkingHours,
      'clockoutStatus': clockoutStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
