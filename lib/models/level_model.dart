class Level {
  String? id;
  String? companyId;
  String? createdByUserId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Level({
    this.id,
    this.companyId,
    this.createdByUserId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      companyId: json['companyId'],
      createdByUserId: json['createdByUserId'],
      name: json['name'],
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Level && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
