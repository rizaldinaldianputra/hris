import 'package:hris/models/dropdown_model.dart';
import 'package:hris/service/dropdown_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart'; // Untuk BuildContext

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
