import 'package:flutter/material.dart';
import 'package:hris/models/attedance_list_logs_model.dart';
import 'package:hris/models/attedance_model.dart';
import 'package:hris/models/attedance_summary_model.dart';
import 'package:hris/service/attedance_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attedant.g.dart';

@riverpod
class AttedantSumamry extends _$AttedantSumamry {
  @override
  Future<AttedanceSummaryModel> build(BuildContext context) async {
    // Inisialisasi state tanpa mengembalikan null
    return Future.value(); // Mengembalikan Future kosong tanpa null
  }

  // Method untuk mengirim data ke API
  Future<AttedanceSummaryModel> dataSummary(
    BuildContext context,
  ) async {
    final attedanceService = AttedanceService(context);
    final response = await attedanceService.summaryAttedance();

    // Mengubah state berdasarkan hasil respons
    state = AsyncValue.data(response);

    return response;
  }
}

@riverpod
class AttedantListLogs extends _$AttedantListLogs {
  @override
  Future<List<AttendanceListLogsModel>> build(BuildContext context) async {
    // Inisialisasi state tanpa mengembalikan null
    return Future.value(); // Mengembalikan Future kosong tanpa null
  }

  // Method untuk mengirim data ke API
  Future<List<AttendanceListLogsModel>> listdataLogs(
    BuildContext context,
  ) async {
    final attedanceService = AttedanceService(context);
    final response = await attedanceService.listLogAttendance();

    // Mengubah state berdasarkan hasil respons
    state = AsyncValue.data(response);

    return response;
  }
}

@riverpod
class AttendanceLogPaginationNotifier
    extends _$AttendanceLogPaginationNotifier {
  final int _initialPage = 1;
  final int _pageSize = 10;
  late final PagingController<int, AttendanceListLogsModel> pagingController;

  late int month;
  late int year;
  late BuildContext context;

  // Inisialisasi
  @override
  Future<void> build() async {
    pagingController = PagingController<int, AttendanceListLogsModel>(
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
      final AttedanceService attendanceService = AttedanceService(context);
      final List<AttendanceListLogsModel> newItems =
          await attendanceService.listLogAttendancePaggination(
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
