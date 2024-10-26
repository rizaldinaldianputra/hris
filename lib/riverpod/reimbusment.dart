import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/expenses_model.dart';
import 'package:hris/models/reimbursement%20_expense_model.dart';
import 'package:hris/service/reimburstment_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reimbusment.g.dart';

@riverpod
class ReimbursementExpenseNotifier extends _$ReimbursementExpenseNotifier {
  @override
  List<ExpensesModel> build() {
    return []; // Initialize with an empty list
  }

  // Method to add a new expense
  void addExpense(ExpensesModel expense) {
    state = [...state, expense]; // Update the state with the new expense
  }

  void removeExpense(int index) {
    if (index >= 0 && index < state.length) {
      state = [
        ...state.sublist(0, index),
        ...state.sublist(index + 1),
      ];
    }
  }
}

@riverpod
class ExpenseList extends _$ExpenseList {
  @override
  Future<List<DropdownModel>> build(BuildContext context) async {
    // Memanggil data dropdown dari service dengan context
    return listType(context);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<List<DropdownModel>> listType(BuildContext context) async {
    final reimburstmentService =
        ReimburstmentService(context); // Inisialisasi service dengan context
    final response = await reimburstmentService.expenseType();
    return response;
  }
}

@riverpod
class ReimbursementImage extends _$ReimbursementImage {
  @override
  List<PlatformFile> build() {
    return []; // Initialize with an empty list
  }

  // Method to add a new expense
  void addImage(PlatformFile expense) {
    state = [...state, expense]; // Update the state with the new expense
  }

  void removeImage(int index) {
    if (index >= 0 && index < state.length) {
      state = [
        ...state.sublist(0, index),
        ...state.sublist(index + 1),
      ];
    }
  }
}
