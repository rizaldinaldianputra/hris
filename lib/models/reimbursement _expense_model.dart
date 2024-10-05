import 'package:uuid/uuid.dart';

class ReimbursementExpenseModel {
  String? id; // uuid
  String? companyId; // uuid
  String? employeeId; // uuid
  String? reimbursementRequestId; // uuid
  String? reimbursementExpenseId; // uuid
  String? name; // string
  double? value; // number
  DateTime? createdAt; // date-time
  DateTime? updatedAt; // date-time

  ReimbursementExpenseModel({
    required this.id,
    required this.companyId,
    required this.employeeId,
    required this.reimbursementRequestId,
    required this.reimbursementExpenseId,
    required this.name,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  // Metode untuk mengonversi objek ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company_id': companyId,
      'employee_id': employeeId,
      'reimbursement_request_id': reimbursementRequestId,
      'reimbursement_expense_id': reimbursementExpenseId,
      'name': name,
      'value': value,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
    };
  }

  ReimbursementExpenseModel.blank();
  // Metode untuk membuat objek dari Map
  factory ReimbursementExpenseModel.fromMap(Map<String, dynamic> map) {
    return ReimbursementExpenseModel(
      id: map['id'] ?? const Uuid().v4(), // Jika id null, buat uuid baru
      companyId: map['company_id'],
      employeeId: map['employee_id'],
      reimbursementRequestId: map['reimbursement_request_id'],
      reimbursementExpenseId: map['reimbursement_expense_id'],
      name: map['name'] ?? '', // Jika name null, set ke string kosong
      value: map['value']?.toDouble() ?? 0.0, // Jika value null, set ke 0.0
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }
}
