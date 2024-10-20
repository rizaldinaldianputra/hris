import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/service/common_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  late CommonService api;
  String url = '/auth';
  String connErr = 'Please check your internet connection and try again';

  AuthService(context, user, [password]) {
    api = CommonService(context);
  }

  Future<Response> authenticate(
      url, String user, String password, context) async {
    final data = {'username': user, 'password': password};
    Response response = await api.postHTTP(url, data);
    if (response.statusCode == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("token", response.data['data']['token']);
    }
    return response;
  }

  Future<Response> logout(url, context) async {
    Response response = await api.postLogout(url);
    return response;
  }
}

Future<void> checkToken(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");
  int? tokenDate = sharedPreferences.getInt("tokendate");

  if (token != null && tokenDate != null) {
    DateTime tokenTime = DateTime.fromMillisecondsSinceEpoch(tokenDate);
    DateTime now = DateTime.now();

    // Cek apakah token sudah kadaluarsa (misalnya, 1 jam)
    if (now.isAfter(tokenTime.add(const Duration(hours: 1)))) {
      // Token sudah kadaluarsa, arahkan ke halaman login
      sharedPreferences.remove("token"); // Hapus token yang sudah kadaluarsa
      sharedPreferences.remove("tokendate");
      context.pushReplacementNamed(
          '/login'); // Ganti dengan route login yang sesuai
    } else {
      // Token masih valid, arahkan ke halaman home
      context
          .pushReplacementNamed('/home'); // Ganti dengan route home yang sesuai
    }
  }
}
