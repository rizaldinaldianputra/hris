import 'package:dio/dio.dart';
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

@riverpod
class UserLogout extends _$UserLogout {
  @override
  Future<String?> build(BuildContext context) async {
    // Inisialisasi UserService dengan context
    return logout(context: context);
  }

  // Fetch dari API menggunakan service dan parsing JSON
  Future<String> logout({required context}) async {
    final userService = UserService(context);
    final response = await userService.logout(context);

    state = AsyncValue.data(response);

    return response;
  }
}

@riverpod
class UserUpdate extends _$UserUpdate {
  @override
  Future<Response?> build(BuildContext context) async {
    // Inisialisasi state tanpa mengembalikan null
    return Future.value(); // Mengembalikan Future kosong tanpa null
  }

  // Method untuk mengirim data ke API
  Future<Response> updateData({
    required BuildContext context,
    required UserModel data,
  }) async {
    final userService = UserService(context);
    final response = await userService.update(context, data);

    // Mengubah state berdasarkan hasil respons
    state = AsyncValue.data(response);

    return response;
  }
}
