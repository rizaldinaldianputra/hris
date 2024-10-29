import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/leave_model.dart';
import 'package:hris/service/common_services.dart';

class LeaveService {
  late CommonService api;
  String url = '$API_URL/leave-requests';
  String connErr = 'Please check your internet connection and try again';

  LeaveService(context) {
    api = CommonService(context);
  }

  Future<List<LeaveModel>> findAllData() async {
    Response response = await api.getHTTP(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      final result = data.map((json) => LeaveModel.fromJson(json)).toList();
      return result;
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<List<DropdownModel>> leaveType(String companyId) async {
    final response =
        await api.getHTTP('$API_URL/master/leave-type?companyId=$companyId');
    if (response.statusCode == 200) {
      final data = response.data['data'];

      // Mengubah data menjadi List<DropdownModel>
      List<DropdownModel> leaveTypes = (data as List).map((item) {
        return DropdownModel.fromJson(item);
      }).toList();

      return leaveTypes;
    } else {
      throw Exception('Failed to load leave types');
    }
  }

  Future<Response> saveLeave(Map<String, dynamic> leave) async {
    try {
      final response = await api.postHTTP('$API_URL/leave-request', leave);

      // Cek jika status code 200 atau sesuai dengan API success response
      if (response.statusCode == 200) {
        return response; // Return seluruh response jika dibutuhkan
      } else {
        throw Exception(
            'Failed to submit leave request: ${response.statusMessage}');
      }
    } catch (e) {
      // Tangani error lebih spesifik
      throw Exception('Error submitting leave request: ${e.toString()}');
    }
  }

  Future<List<LeaveModel>> listLeavePagination({
    required int month,
    required int years,
    required int page,
    required int perpage,
  }) async {
    final response = await api.getHTTP(
        '$API_URL/leave-requests?month=$month&year=$years&page=$page&perPage=$perpage');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      List<LeaveModel> attendanceLogs = (data as List).map((item) {
        return LeaveModel.fromJson(item);
      }).toList();

      return attendanceLogs;
    } else {
      throw Exception('Failed to load attendance logs');
    }
  }
}
