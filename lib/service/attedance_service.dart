import 'package:dio/dio.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/attedance_model.dart';
import 'package:hris/models/attedance_summary_model.dart';
import 'package:hris/service/common_services.dart';
import 'package:intl/intl.dart';

class AttedanceService {
  late CommonService api;
  late Response response;
  String url = API_URL;
  String connErr = 'Please check your internet connection and try again';

  AttedanceService(context) {
    api = CommonService(context);
  }

  Future<AttedanceSummaryModel> summaryAttedance() async {
    final response = await api.getHTTP('$url/attendance-summary');
    if (response.statusCode == 200) {
      final data = response.data['data'];
      AttedanceSummaryModel attedanceSummaryModel =
          AttedanceSummaryModel.fromJson(data);

      return attedanceSummaryModel;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<List<AttendanceModel>> listLogAttendance() async {
    final response = await api.getHTTP('$url/attendances');

    if (response.statusCode == 200) {
      final data = response.data['data'];

      List<AttendanceModel> attendanceLogs = (data as List).map((item) {
        return AttendanceModel.fromJson(item);
      }).toList();

      return attendanceLogs;
    } else {
      throw Exception('Failed to load attendance logs');
    }
  }

  Future<List<AttendanceModel>> listLogAttendancePaggination({
    required int month,
    required int years,
    required int page,
    required int perpage,
  }) async {
    final response = await api.getHTTP(
        '$url/attendances?month=$month&year=$years&page=$page&perPage=$perpage');

    if (response.statusCode == 200) {
      final data = response.data['data'];
      List<AttendanceModel> attendanceLogs = (data as List).map((item) {
        return AttendanceModel.fromJson(item);
      }).toList();
      return attendanceLogs;
    } else {
      throw Exception('Failed to load attendance logs');
    }
  }

  Future<AttendanceModel> attedanceStatus() async {
    final String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    final response = await api.getHTTP('$url/attendance?date=$formattedDate');
    if (response.statusCode == 200) {
      final data = response.data['data'];
      AttendanceModel attedandeStatus = AttendanceModel.fromJson(data);

      return attedandeStatus;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Response> saveAttedance(
      Map<String, dynamic> attedance, String action) async {
    try {
      final response =
          await api.putHTTP('$API_URL/attendance/$action', attedance);

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
}
