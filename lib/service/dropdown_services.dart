import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/riverpod/masterdropdown.dart';
import 'package:hris/service/common_services.dart';

import '../riverpod/session.dart';

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

  Future<List<DropdownModel>> dropdownMonth(WidgetRef ref) async {
    final response = await api.getHTTP('$url/master/months');

    if (response.statusCode == 200) {
      final data = response.data['data'];

      // Mapping data menjadi list model DropdownModel
      List<DropdownModel> listDropdown = (data as List).map((item) {
        return DropdownModel(
          key: item['key'] as String,
          value: item['value'] as String, // Misalnya ada field 'value' di model
        );
      }).toList();
      await saveMonth(listDropdown);

      // Menyimpan data listDropdown ke Riverpod state
      ref.read(dropdownMonthProvider.notifier).setDropdownList(listDropdown);
      return listDropdown;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<DropdownModelYears>> dropdownYears(WidgetRef ref) async {
    final response = await api.getHTTP('$url/master/years');

    if (response.statusCode == 200) {
      final data = response.data['data'];

      // Mapping data menjadi list model DropdownModel
      List<DropdownModelYears> listDropdown = (data as List).map((item) {
        return DropdownModelYears(
          key: item['key'] as int,
          value: item['value'] as int, // Misalnya ada field 'value' di model
        );
      }).toList();
      await saveYears(listDropdown);

      ref.read(dropdownYearsProvider.notifier).setDropdownList(listDropdown);
      return listDropdown;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
