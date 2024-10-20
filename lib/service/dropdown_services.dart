import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/service/common_services.dart';

class DropdownServices {
  late CommonService api;
  late Response response;
  String url = API_URL;
  String connErr = 'Please check your internet connection and try again';

  DropdownServices(context) {
    api = CommonService(context);
  }

  Future<List<String>> dropdown(String value) async {
    final response = await api.getHTTP('$url/master/$value');

    if (response.statusCode == 200) {
      final data = response.data['data'];

      // Mengambil hanya key dari response data
      List<String> listDropdown = (data as List).map((item) {
        return item['key'] as String; // Mengambil key dari setiap item
      }).toList();

      return listDropdown;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
