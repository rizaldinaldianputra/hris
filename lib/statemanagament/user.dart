import 'package:hris/models/user_model.dart';
import 'package:hris/service/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';

part 'user.g.dart';

@riverpod
class UserData extends _$UserData {
  @override
  Future<UserModel?> build(BuildContext context) async {
    // Inisialisasi UserService dengan context
    return dataUser(context: context);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<UserModel> dataUser({required context}) async {
    final userService = UserService(context);
    final response = await userService.findUser();
    state = AsyncValue.data(response);
    return response;
  }
}
