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

@Riverpod(keepAlive: false)
class OvertimeList extends _$OvertimeList {
  late PagingController<int, Overtime> pagingController;

  @override
  late BuildContext context;
  String searchQuery = ''; // Add searchQuery state

  @override
  PagingController<int, Overtime> build(BuildContext context) {
    this.context = context; // Store the context
    pagingController = PagingController<int, Overtime>(firstPageKey: 0);
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey: pageKey, pageSize: 10);
    });

    return pagingController;
  }

  Future<void> fetchPage({
    required int pageKey,
    required int pageSize,
  }) async {
    try {
      final overtimeService = OvertimeService(context);
      final newItems = await overtimeService.findAllData();

      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error; // Make sure to handle errors here
      // You can log the error for debugging purposes
      print('Error fetching page: $error');
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