class Position {
  String? id;
  String? companyId;
  String? departmentId;
  String? name;
  String? description;
  String? createdByUserId;
  String? prefix;
  DateTime? createdAt;
  DateTime? updatedAt;

  Position({
    this.id,
    this.companyId,
    this.departmentId,
    this.name,
    this.description,
    this.createdByUserId,
    this.prefix,
    this.createdAt,
    this.updatedAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      companyId: json['companyId'],
      departmentId: json['departmentId'],
      name: json['name'],
      description: json['description'],
      createdByUserId: json['createdByUserId'],
      prefix: json['prefix'],
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
      'departmentId': departmentId,
      'name': name,
      'description': description,
      'createdByUserId': createdByUserId,
      'prefix': prefix,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
