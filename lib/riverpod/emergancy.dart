import 'package:flutter/material.dart';
import 'package:hris/models/emergency_model.dart';
import 'package:hris/service/emergancy_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'emergancy.g.dart';

@riverpod
class EmergancyListView extends _$EmergancyListView {
  @override
  late BuildContext context;

  @override
  Future<List<EmergencyModel>> build(BuildContext context) {
    this.context = context; // Simpan context
    return fetchData();
  }

  Future<List<EmergencyModel>> fetchData() async {
    try {
      final emergancyService = EmergancyService(context);
      final newItems = await emergancyService.listEmergancy();
      return newItems;
    } catch (e) {
      return [];
    }
  }
}
