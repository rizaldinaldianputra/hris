import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/expenses_model.dart';
import 'package:hris/models/reimbursement%20_expense_model.dart';
import 'package:hris/models/reimbusment_model.dart';
import 'package:hris/service/reimburstment_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
    // Cek apakah expense sudah ada dalam state berdasarkan ID atau atribut unik lainnya
    if (!state.any((e) =>
        e.expensesId == expense.expensesId && e.value == expense.value)) {
      state = [
        ...state,
        expense,
      ]; // Update the state with the new expense if it's unique
    }
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
class ReimbusmentType extends _$ReimbusmentType {
  @override
  Future<List<DropdownModel>> build(BuildContext context, String value) async {
    // Memanggil data dropdown dari service dengan context
    return listType(context, value);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<List<DropdownModel>> listType(
      BuildContext context, String value) async {
    final reimburstmentService =
        ReimburstmentService(context); // Inisialisasi service dengan context
    final response = await reimburstmentService.reimbustmentType(value);
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

@riverpod
class ReimbusmentSaveData extends _$ReimbusmentSaveData {
  @override
  Future<Response?> build(BuildContext context) async {
    return Future.value(); // Kembalikan null saat inisialisasi
  }

  // Method untuk mengirim data ke API
  Future<Response> saveData({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) async {
    // Set state menjadi loading saat proses pengiriman
    state = const AsyncValue.loading();

    try {
      final rembusmentService = ReimburstmentService(context);
      final response = await rembusmentService.saveReimbusment(data);

      // Mengubah state menjadi data jika sukses
      state = AsyncValue.data(response);
      return response;
    } catch (error) {
      // Menangani error dan mengubah state menjadi error
      rethrow; // Melempar ulang error untuk penanganan lebih lanjut jika diperlukan
    }
  }
}

@riverpod
class ReimbusmentPending extends _$ReimbusmentPending {
  final int _initialPage = 1;
  final int _pageSize = 10;
  late final PagingController<int, ReimbursementModel> pagingController;

  late int month;
  late int year;
  late BuildContext context;

  // Inisialisasi
  @override
  Future<void> build() async {
    pagingController = PagingController<int, ReimbursementModel>(
      firstPageKey: _initialPage,
    );
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // Fungsi untuk mengatur parameter yang diterima dari view
  void setParameters({
    required int monthParam,
    required int yearParam,
    required BuildContext contextParam,
  }) {
    month = monthParam;
    year = yearParam;
    context = contextParam;
    refreshPaging();
  }

  // Fungsi untuk memuat ulang data ketika parameter berubah
  void refreshPaging() {
    pagingController.refresh();
  }

  // Mendapatkan data dengan pagination
  Future<void> _fetchPage(int pageKey) async {
    try {
      final ReimburstmentService reimburstmentService =
          ReimburstmentService(context);
      final List<ReimbursementModel> newItems =
          await reimburstmentService.listReimbrusmentPagintion(
              month: month,
              years: year,
              page: pageKey,
              perpage: _pageSize,
              status: 'pending');

      // Jika item kurang dari pageSize, maka set akhir data (no more data)
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void updateDate({required int newMonth, required int newYear}) {
    if (month != newMonth || year != newYear) {
      month = newMonth;
      year = newYear;
      refreshPaging(); // Memuat ulang data dengan parameter baru
    }
  }
}

@riverpod
class RembusmentApproved extends _$RembusmentApproved {
  final int _initialPage = 1;
  final int _pageSize = 10;
  late final PagingController<int, ReimbursementModel> pagingController;

  late int month;
  late int year;
  late BuildContext context;

  // Inisialisasi
  @override
  Future<void> build() async {
    pagingController = PagingController<int, ReimbursementModel>(
      firstPageKey: _initialPage,
    );
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // Fungsi untuk mengatur parameter yang diterima dari view
  void setParameters({
    required int monthParam,
    required int yearParam,
    required BuildContext contextParam,
  }) {
    month = monthParam;
    year = yearParam;
    context = contextParam;
    refreshPaging();
  }

  // Fungsi untuk memuat ulang data ketika parameter berubah
  void refreshPaging() {
    pagingController.refresh();
  }

  // Mendapatkan data dengan pagination
  Future<void> _fetchPage(int pageKey) async {
    try {
      final ReimburstmentService reimburstmentService =
          ReimburstmentService(context);
      final List<ReimbursementModel> newItems =
          await reimburstmentService.listReimbrusmentPagintion(
              month: month,
              years: year,
              page: pageKey,
              perpage: _pageSize,
              status: 'approved');

      // Jika item kurang dari pageSize, maka set akhir data (no more data)
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void updateDate({required int newMonth, required int newYear}) {
    if (month != newMonth || year != newYear) {
      month = newMonth;
      year = newYear;
      refreshPaging(); // Memuat ulang data dengan parameter baru
    }
  }
}
