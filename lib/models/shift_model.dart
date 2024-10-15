class Shift {
  String? id;
  String? companyId;
  String? createdByUserId;
  String? name;
  String? startTime;
  String? endTime;
  bool? defaultShift;
  DateTime? createdAt;
  DateTime? updatedAt;

  Shift({
    this.id,
    this.companyId,
    this.createdByUserId,
    this.name,
    this.startTime,
    this.endTime,
    this.defaultShift,
    this.createdAt,
    this.updatedAt,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['id'],
      companyId: json['companyId'],
      createdByUserId: json['createdByUserId'],
      name: json['name'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      defaultShift: json['defaultShift'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'createdByUserId': createdByUserId,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'defaultShift': defaultShift,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shift && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
