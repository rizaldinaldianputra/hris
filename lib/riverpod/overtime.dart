import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/leave_model.dart';
import 'package:hris/models/overtime_model.dart';
import 'package:hris/service/leave_service.dart';
import 'package:hris/service/overtime_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'overtime.g.dart';

@riverpod
class OvertimePagination extends _$OvertimePagination {
  final int _initialPage = 1;
  final int _pageSize = 10;
  late final PagingController<int, Overtime> pagingController;

  late int month;
  late int year;
  late BuildContext context;

  // Inisialisasi
  @override
  Future<void> build() async {
    pagingController = PagingController<int, Overtime>(
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
      final OvertimeService overtimeService = OvertimeService(context);
      final List<Overtime> newItems =
          await overtimeService.listOvertimePagintion(
        month: month,
        years: year,
        page: pageKey,
        perpage: _pageSize,
      );

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
class OvertimeListView extends _$OvertimeListView {
  @override
  late BuildContext context;

  @override
  Future<List<Overtime>> build(BuildContext context) {
    this.context = context; // Simpan context
    return fetchData();
  }

  Future<List<Overtime>> fetchData() async {
    try {
      final overtimeService = OvertimeService(context);
      final newItems = await overtimeService.findAllData();
      return newItems;
    } catch (e) {
      return [];
    }
  }
}

@riverpod
class OvertimeType extends _$OvertimeType {
  @override
  Future<List<DropdownModel>> build(BuildContext context, String value) async {
    // Memanggil data dropdown dari service dengan context
    return listType(context, value);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<List<DropdownModel>> listType(
      BuildContext context, String value) async {
    final overtimeService =
        OvertimeService(context); // Inisialisasi service dengan context
    final response = await overtimeService.overtimeType(value);
    return response;
  }
}

@riverpod
class OvertimeSaveData extends _$OvertimeSaveData {
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
      final overtimeService = OvertimeService(context);
      final response = await overtimeService.saveOvertime(data);

      // Mengubah state menjadi data jika sukses
      state = AsyncValue.data(response);
      return response;
    } catch (error) {
      // Menangani error dan mengubah state menjadi error
      rethrow; // Melempar ulang error untuk penanganan lebih lanjut jika diperlukan
    }
  }
}
