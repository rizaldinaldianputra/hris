class EmployeeShift {
  String? id;
  String? companyId;
  String? createdByUserId;
  String? name;
  String? startTime;
  String? endTime;
  bool? isDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  Map<String, int>? workingDays;

  EmployeeShift({
    required this.id,
    required this.companyId,
    required this.createdByUserId,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.workingDays,
  });
  EmployeeShift.blank();
  factory EmployeeShift.fromJson(Map<String, dynamic> json) {
    return EmployeeShift(
      id: json['id'],
      companyId: json['companyId'],
      createdByUserId: json['createdByUserId'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isDefault: json['default'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      workingDays: {
        'Monday': json['wdMonday'],
        'Tuesday': json['wdTuesday'],
        'Wednesday': json['wdWednesday'],
        'Thursday': json['wdThursday'],
        'Friday': json['wdFriday'],
        'Saturday': json['wdSaturday'],
        'Sunday': json['wdSunday'],
      },
    );
  }
}
