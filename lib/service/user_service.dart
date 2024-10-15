import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/service/common_services.dart';

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
      // response.data['data'] diambil\ langsung tanpa json.decode()
      final data = response.data['data'];
      print(data);
      // Pastikan UserModel dapat menerima Map<String, dynamic>
      UserModel userModel = UserModel.fromJson(data);

      return userModel;
    } else {
      throw Exception('Failed to load user');
    }
  }
}
