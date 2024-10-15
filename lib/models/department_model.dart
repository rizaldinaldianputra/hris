class Department {
  String? id;
  String? companyId;
  String? name;
  String? description;
  String? headDepartmentId;
  String? createdByUserId;
  String? prefix;
  DateTime? createdAt;
  DateTime? updatedAt;

  Department({
    this.id,
    this.companyId,
    this.name,
    this.description,
    this.headDepartmentId,
    this.createdByUserId,
    this.prefix,
    this.createdAt,
    this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      companyId: json['companyId'],
      name: json['name'],
      description: json['description'],
      headDepartmentId: json[
          'headDepartmentId'], // Memperbaiki kesalahan ketik dari 'headDepartmenId'
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
      'name': name,
      'description': description,
      'headDepartmentId': headDepartmentId,
      'createdByUserId': createdByUserId,
      'prefix': prefix,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Department && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
