import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/service/common_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  late CommonService api;
  late Response response;
  String url = API_URL;
  String connErr = 'Please check your internet connection and try again';

  UserService(context) {
    api = CommonService(context);
  }

  Future<UserModel> findUser() async {
    final response = await api.getHTTP('$url/profile');
    if (response.statusCode == 200) {
      final data = response.data['data'];
      UserModel userModel = UserModel.fromJson(data);

      return userModel;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<String> logout(context) async {
    final response = await api.postLogout('$url/auth/logout');
    if (response.statusCode == 200) {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove("token");
      GoRouter.of(context).pushReplacementNamed('login');

      return response.data;
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Response> update(context, data) async {
    final response = await api.putHTTP('$url/profile', data);
    if (response.statusCode == 200) {
      GoRouter.of(context).pop();
      return response.data;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
