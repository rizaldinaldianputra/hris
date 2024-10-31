import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<List<AttendanceModel>> build(BuildContext context) async {
    // Inisialisasi state tanpa mengembalikan null
    return Future.value(); // Mengembalikan Future kosong tanpa null
  }

  // Method untuk mengirim data ke API
  Future<List<AttendanceModel>> listdataLogs(
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
  late final PagingController<int, AttendanceModel> pagingController;

  late int month;
  late int year;
  late BuildContext context;

  // Inisialisasi
  @override
  Future<void> build() async {
    pagingController = PagingController<int, AttendanceModel>(
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
      final List<AttendanceModel> newItems =
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

@riverpod
class AttedanceStatus extends _$AttedanceStatus {
  @override
  Future<AttendanceModel?> build(BuildContext context) async {
    // Inisialisasi UserService dengan context
    return dataUser(context: context);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<AttendanceModel> dataUser({required context}) async {
    final attedanceService = AttedanceService(context);
    final response = await attedanceService.attedanceStatus();
    state = AsyncValue.data(response);
    return response;
  }
}

final latProvider = StateProvider<String>((ref) => "");
final longProvider = StateProvider<String>((ref) => "");
final statusProvider = StateProvider<String>((ref) => "");

@riverpod
class AttedantSave extends _$AttedantSave {
  @override
  Future<Response?> build(BuildContext context) async {
    return Future.value(); // Kembalikan null saat inisialisasi
  }

  // Method untuk mengirim data ke API
  Future<Response> saveData(
      {required BuildContext context,
      required Map<String, dynamic> data,
      required String url}) async {
    // Set state menjadi loading saat proses pengiriman
    state = const AsyncValue.loading();

    try {
      final attedantService = AttedanceService(context);
      final response = await attedantService.saveAttedance(data, url);

      // Mengubah state menjadi data jika sukses
      state = AsyncValue.data(response);
      return response;
    } catch (error) {
      // Menangani error dan mengubah state menjadi error
      rethrow; // Melempar ulang error untuk penanganan lebih lanjut jika diperlukan
    }
  }
}

class XFileNotifier extends StateNotifier<XFile?> {
  XFileNotifier() : super(null);

  // Set XFile ke dalam state
  void setXFile(XFile? file) {
    state = file;
  }

  // Mengembalikan data Uint8List dari XFile
  Future<Uint8List?> loadImageFromXFile() async {
    if (state != null) {
      return await state!.readAsBytes();
    }
    return null; // Mengembalikan null jika state belum diatur
  }
}

// StateNotifierProvider untuk XFile
final xFileProvider = StateNotifierProvider<XFileNotifier, XFile?>((ref) {
  return XFileNotifier();
});

// FutureProvider untuk Uint8List (data gambar) dari XFile
final imageBytesProvider = FutureProvider<Uint8List?>((ref) async {
  final xFileNotifier = ref.watch(xFileProvider.notifier);
  return await xFileNotifier.loadImageFromXFile();
});
