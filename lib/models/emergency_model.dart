class EmergencyModel {
  String? id;
  String? employeeId;
  String? familyRelation;
  String? name;
  String? phone;
  String? address;
  String? country;
  String? province;
  String? city;
  String? district;
  String? subDistrict;
  String? zipCode;
  DateTime? createdAt;
  DateTime? updatedAt;

  EmergencyModel({
    this.id,
    this.employeeId,
    this.familyRelation,
    this.name,
    this.phone,
    this.address,
    this.country,
    this.province,
    this.city,
    this.district,
    this.subDistrict,
    this.zipCode,
    this.createdAt,
    this.updatedAt,
  });

  factory EmergencyModel.fromJson(Map<String, dynamic> json) {
    return EmergencyModel(
      id: json['id'],
      employeeId: json['employeeId'],
      familyRelation: json['familyRelation'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      country: json['country'],
      province: json['province'],
      city: json['city'],
      district: json['district'],
      subDistrict: json['subDistrict'],
      zipCode: json['zipCode'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'familyRelation': familyRelation,
      'name': name,
      'phone': phone,
      'address': address,
      'country': country,
      'province': province,
      'city': city,
      'district': district,
      'subDistrict': subDistrict,
      'zipCode': zipCode,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
