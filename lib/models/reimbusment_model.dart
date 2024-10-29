class ReimbursementModel {
  final String id;
  final ReimbursementType reimbursementType;
  final String date;
  final double total;
  final String status;
  final String? manager;
  final List<Expense> expenses;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReimbursementModel({
    required this.id,
    required this.reimbursementType,
    required this.date,
    required this.total,
    required this.status,
    this.manager,
    required this.expenses,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReimbursementModel.fromJson(Map<String, dynamic> json) {
    return ReimbursementModel(
      id: json['id'],
      reimbursementType: ReimbursementType.fromJson(json['reimbursementType']),
      date: json['date'],
      total: (json['total'] as num).toDouble(),
      status: json['status'],
      manager: json['manager'],
      expenses: (json['expenses'] as List)
          .map((expense) => Expense.fromJson(expense))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reimbursementType': reimbursementType.toJson(),
      'date': date,
      'total': total,
      'status': status,
      'manager': manager,
      'expenses': expenses.map((expense) => expense.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class ReimbursementType {
  final String id;
  final String name;

  ReimbursementType({
    required this.id,
    required this.name,
  });

  factory ReimbursementType.fromJson(Map<String, dynamic> json) {
    return ReimbursementType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Expense {
  final String expensesId;
  final String name;
  final double value;

  Expense({
    required this.expensesId,
    required this.name,
    required this.value,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      expensesId: json['expensesId'],
      name: json['name'],
      value: (json['value'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expensesId': expensesId,
      'name': name,
      'value': value,
    };
  }
}
