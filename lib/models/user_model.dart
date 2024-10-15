import 'package:hris/models/company_model.dart';
import 'package:hris/models/department_model.dart';
import 'package:hris/models/level_model.dart';
import 'package:hris/models/posisition_model.dart';
import 'package:hris/models/shift_model.dart';

class UserModel {
  int? id;
  String? companyId;
  String? employeeId;
  String? employeeShiftId;
  String? firstName;
  String? lastName;
  String? email;
  String? nik;
  String? passwordUpdatedAt;
  String? phone;
  String? departmentId;
  String? employeePositionId;
  String? employeeLevelId;
  double? salary;
  String? image;
  double? reimbursementLimit;
  String? createdByUserId;
  DateTime? birthDate;
  String? username;
  String? birthPlace;
  String? religion;
  String? maritalStatus;
  String? gender;
  String? nationality;
  String? country;
  String? address;
  String? province;
  String? city;
  String? district;
  String? subDistrict;
  String? zipCode;
  DateTime? joinDate;
  String? documentId;
  bool? documentIsUnlimited;
  String? documentFile;
  DateTime? documentExpiry;
  String? taxRegisteredName;
  String? taxNumber;
  String? bankAccountNumber;
  String? bankAccountName;
  String? headDepartmentId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Department? department;
  Position? position;
  Level? level;
  Shift? shift;
  Company? company;
  dynamic head;

  UserModel({
    this.id,
    this.companyId,
    this.employeeId,
    this.employeeShiftId,
    this.firstName,
    this.lastName,
    this.email,
    this.nik,
    this.passwordUpdatedAt,
    this.phone,
    this.departmentId,
    this.employeePositionId,
    this.employeeLevelId,
    this.salary,
    this.image,
    this.reimbursementLimit,
    this.createdByUserId,
    this.birthDate,
    this.username,
    this.birthPlace,
    this.religion,
    this.maritalStatus,
    this.gender,
    this.nationality,
    this.country,
    this.address,
    this.province,
    this.city,
    this.district,
    this.subDistrict,
    this.zipCode,
    this.joinDate,
    this.documentId,
    this.documentIsUnlimited,
    this.documentFile,
    this.documentExpiry,
    this.taxRegisteredName,
    this.taxNumber,
    this.bankAccountNumber,
    this.bankAccountName,
    this.headDepartmentId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.department,
    this.position,
    this.level,
    this.shift,
    this.company,
    this.head,
  });

  // Factory method to parse JSON into UserModel with null safety
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      companyId: json['companyId'] as String?,
      employeeId: json['employeeId'] as String?,
      employeeShiftId: json['employeeShiftId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      nik: json['nik'] as String?,
      passwordUpdatedAt: json['passwordUpdatedAt'] as String?,
      phone: json['phone'] as String?,
      departmentId: json['departmentId'] as String?,
      employeePositionId: json['employeePositionId'] as String?,
      employeeLevelId: json['employeeLevelId'] as String?,
      salary: (json['salary'] as num?)?.toDouble(),
      image: json['image'] as String?,
      reimbursementLimit: (json['reimbursementLimit'] as num?)?.toDouble(),
      createdByUserId: json['createdByUserId'] as String?,
      birthDate: json['birthDate'] != null
          ? DateTime.parse(json['birthDate'] as String)
          : null,
      username: json['username'] as String?,
      birthPlace: json['birthPlace'] as String?,
      religion: json['religion'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      country: json['country'] as String?,
      address: json['address'] as String?,
      province: json['province'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      subDistrict: json['subDistrict'] as String?,
      zipCode: json['zipCode'] as String?,
      joinDate: json['joinDate'] != null
          ? DateTime.parse(json['joinDate'] as String)
          : null,
      documentId: json['documentId'] as String?,
      documentIsUnlimited: json['documentIsUnlimited'] as bool?,
      documentFile: json['documentFile'] as String?,
      documentExpiry: json['documentExpiry'] != null
          ? DateTime.parse(json['documentExpiry'] as String)
          : null,
      taxRegisteredName: json['taxRegisteredName'] as String?,
      taxNumber: json['taxNumber'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      bankAccountName: json['bankAccountName'] as String?,
      headDepartmentId: json['headDepartmentId'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      department: json['department'] != null
          ? Department.fromJson(json['department'] as Map<String, dynamic>)
          : null,
      position: json['position'] != null
          ? Position.fromJson(json['position'] as Map<String, dynamic>)
          : null,
      level: json['level'] != null
          ? Level.fromJson(json['level'] as Map<String, dynamic>)
          : null,
      shift: json['shift'] != null
          ? Shift.fromJson(json['shift'] as Map<String, dynamic>)
          : null,
      company: json['company'] != null
          ? Company.fromJson(json['company'] as Map<String, dynamic>)
          : null,
      head: json['head'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyId': companyId,
      'employeeId': employeeId,
      'employeeShiftId': employeeShiftId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'nik': nik,
      'passwordUpdatedAt': passwordUpdatedAt,
      'phone': phone,
      'departmentId': departmentId,
      'employeePositionId': employeePositionId,
      'employeeLevelId': employeeLevelId,
      'salary': salary,
      'image': image,
      'reimbursementLimit': reimbursementLimit,
      'createdByUserId': createdByUserId,
      'birthDate': birthDate?.toIso8601String(),
      'username': username,
      'birthPlace': birthPlace,
      'religion': religion,
      'maritalStatus': maritalStatus,
      'gender': gender,
      'nationality': nationality,
      'country': country,
      'address': address,
      'province': province,
      'city': city,
      'district': district,
      'subDistrict': subDistrict,
      'zipCode': zipCode,
      'joinDate': joinDate?.toIso8601String(),
      'documentId': documentId,
      'documentIsUnlimited': documentIsUnlimited,
      'documentFile': documentFile,
      'documentExpiry': documentExpiry?.toIso8601String(),
      'taxRegisteredName': taxRegisteredName,
      'taxNumber': taxNumber,
      'bankAccountNumber': bankAccountNumber,
      'bankAccountName': bankAccountName,
      'headDepartmentId': headDepartmentId,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'department': department?.toJson(),
      'position': position?.toJson(),
      'level': level?.toJson(),
      'shift': shift?.toJson(),
      'company': company?.toJson(),
      'head': head,
    };
  }

  UserModel.blank();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
