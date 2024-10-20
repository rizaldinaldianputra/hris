import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/attedance_list_logs_model.dart';
import 'package:hris/models/attedance_summary_model.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/service/common_services.dart';
import 'package:hris/statemanagament/attedant.dart';

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

  Future<List<AttendanceListLogsModel>> listLogAttendance() async {
    final response = await api.getHTTP('$url/attendances');

    if (response.statusCode == 200) {
      final data = response.data['data'];

      // Mengubah data menjadi List<AttendanceListLogsModel>
      List<AttendanceListLogsModel> attendanceLogs = (data as List).map((item) {
        return AttendanceListLogsModel.fromJson(item);
      }).toList();

      return attendanceLogs;
    } else {
      throw Exception('Failed to load attendance logs');
    }
  }
}
