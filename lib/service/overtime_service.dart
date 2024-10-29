import 'package:dio/dio.dart';

import 'package:hris/config/constant.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/overtime_model.dart';
import 'package:hris/service/common_services.dart';

class OvertimeService {
  late CommonService api;
  String url = '$API_URL/overtime-requests';
  String connErr = 'Please check your internet connection and try again';

  OvertimeService(context) {
    api = CommonService(context);
  }

  Future<List<Overtime>> findAllData() async {
    Response response = await api.getHTTP(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data['data'];
      final result = data.map((json) => Overtime.fromJson(json)).toList();
      return result;
    } else {
      throw Exception('Failed to load list');
    }
  }

  Future<List<DropdownModel>> overtimeType(String companyId) async {
    final response =
        await api.getHTTP('$API_URL/master/overtime-type?companyId=$companyId');
    if (response.statusCode == 200) {
      final data = response.data['data'];

      // Mengubah data menjadi List<DropdownModel>
      List<DropdownModel> overtimeTypes = (data as List).map((item) {
        return DropdownModel.fromJson(item);
      }).toList();

      return overtimeTypes;
    } else {
      throw Exception('Failed to load leave types');
    }
  }

  Future<Response> saveOvertime(Map<String, dynamic> overtime) async {
    try {
      final response =
          await api.postHTTP('$API_URL/overtime-request', overtime);

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

  Future<List<Overtime>> listOvertimePagintion(
      {required int month,
      required int years,
      required int page,
      required int perpage,
      required String status}) async {
    final response = await api.getHTTP(
        '$API_URL/overtime-requests?month=$month&year=$years&page=$page&perPage=$perpage&status=$status');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      List<Overtime> attendanceLogs = (data as List).map((item) {
        return Overtime.fromJson(item);
      }).toList();

      return attendanceLogs;
    } else {
      throw Exception('Failed to load attendance logs');
    }
  }
}
