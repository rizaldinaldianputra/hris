import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/leave_model.dart';
import 'package:hris/service/leave_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'leave.g.dart';

@Riverpod(keepAlive: false)
class LeaveList extends _$LeaveList {
  late PagingController<int, LeaveModel> pagingController;

  @override
  late BuildContext context;
  String searchQuery = ''; // Add searchQuery state

  @override
  PagingController<int, LeaveModel> build(BuildContext context) {
    this.context = context; // Store the context
    pagingController = PagingController<int, LeaveModel>(firstPageKey: 0);
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
      final leaveService = LeaveService(context);
      final newItems = await leaveService.findAllData();

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
class LeaveListView extends _$LeaveListView {
  @override
  late BuildContext context;

  @override
  Future<List<LeaveModel>> build(BuildContext context) {
    this.context = context; // Simpan context
    return fetchData();
  }

  Future<List<LeaveModel>> fetchData() async {
    try {
      final leaveService = LeaveService(context);
      final newItems = await leaveService.findAllData();
      return newItems;
    } catch (e) {
      return [];
    }
  }
}

@riverpod
class LeaveType extends _$LeaveType {
  @override
  Future<List<DropdownModel>> build(BuildContext context, String value) async {
    // Memanggil data dropdown dari service dengan context
    return listType(context, value);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<List<DropdownModel>> listType(
      BuildContext context, String value) async {
    final leaveService =
        LeaveService(context); // Inisialisasi service dengan context
    final response = await leaveService.leaveType(value);
    return response;
  }
}

@riverpod
class LeaveSaveData extends _$LeaveSaveData {
  @override
  Future<Response?> build(BuildContext context) async {
    // Inisialisasi state tanpa mengembalikan null
    return Future.value(); // Mengembalikan Future kosong tanpa null
  }

  // Method untuk mengirim data ke API
  Future<Response> saveData({
    required BuildContext context,
    required data,
  }) async {
    final leaveService = LeaveService(context);
    final response = await leaveService.saveLeave(data);

    // Mengubah state berdasarkan hasil respons
    state = AsyncValue.data(response);

    return response;
  }
}
