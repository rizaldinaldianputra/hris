import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/service/dropdown_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';

part 'masterdropdown.g.dart';

@riverpod
class MasterDropdownList extends _$MasterDropdownList {
  @override
  Future<List<String>> build(BuildContext context, String value) async {
    // Memanggil data dropdown dari service dengan context
    return dataDropdown(context, value);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<List<String>> dataDropdown(BuildContext context, String value) async {
    final dropdownService =
        DropdownServices(context); // Inisialisasi service dengan context
    final response = await dropdownService.dropdown(value);
    return response;
  }
}

class DropDownMonth extends StateNotifier<List<DropdownModel>> {
  DropDownMonth() : super([]);

  // Menyimpan data dropdown
  void setDropdownList(List<DropdownModel> newList) {
    state = newList;
  }

  // Menambah item ke list
  void addDropdownItem(DropdownModel item) {
    state = [...state, item];
  }
}

// StateNotifierProvider untuk mengakses dan mengelola List<DropdownModel>
final dropdownMonthProvider =
    StateNotifierProvider<DropDownMonth, List<DropdownModel>>((ref) {
  return DropDownMonth();
});

class DropDownYears extends StateNotifier<List<DropdownModelYears>> {
  DropDownYears() : super([]);

  // Menyimpan data dropdown
  void setDropdownList(List<DropdownModelYears> newList) {
    state = newList;
  }

  // Menambah item ke list
  void addDropdownItem(DropdownModelYears item) {
    state = [...state, item];
  }
}

// StateNotifierProvider untuk mengakses dan mengelola List<DropdownModel>
final dropdownYearsProvider =
    StateNotifierProvider<DropDownYears, List<DropdownModelYears>>((ref) {
  return DropDownYears();
});
