import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/models/reimbursement%20_expense_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'reimbusment.g.dart';

@riverpod
class ReimbursementExpenseNotifier extends _$ReimbursementExpenseNotifier {
  @override
  List<ReimbursementExpenseModel> build() {
    return []; // Initialize with an empty list
  }

  // Method to add a new expense
  void addExpense(ReimbursementExpenseModel expense) {
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
