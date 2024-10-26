class ExpensesModel {
  final String expensesId; // Menyimpan ID expense
  final double value; // Menyimpan nilai expense

  ExpensesModel({
    required this.expensesId,
    required this.value,
  });

  // Mengonversi dari JSON ke objek ExpensesModel
  factory ExpensesModel.fromJson(Map<String, dynamic> json) {
    return ExpensesModel(
      expensesId: json['expensesId'],
      value: json['value'].toDouble(), // Pastikan untuk mengonversi ke double
    );
  }

  // Mengonversi dari objek ExpensesModel ke JSON
  Map<String, dynamic> toJson() {
    return {
      'expensesId': expensesId,
      'value': value,
    };
  }
}
