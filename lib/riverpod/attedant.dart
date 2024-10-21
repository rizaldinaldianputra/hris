import 'package:flutter/material.dart';
import 'package:hris/models/attedance_list_logs_model.dart';
import 'package:hris/models/attedance_model.dart';
import 'package:hris/models/attedance_summary_model.dart';
import 'package:hris/service/attedance_service.dart';
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
