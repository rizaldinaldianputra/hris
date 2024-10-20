import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/config/constant.dart';
import 'package:hris/service/auth_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
AuthService authService(context, user) {
  return AuthService(context, user);
}

Future doLogin(String user, String password, context) async {
  final authServices = authService(context, user);

  if (user == '') {
    Fluttertoast.showToast(
        msg: 'Username tidak boleh kosong',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13);
    return;
  } else if (password == '') {
    Fluttertoast.showToast(
        msg: 'Password tidak boleh kosong',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13);
    return;
  }
  Response? response = await authServices.authenticate(
      '$API_URL/auth/login', user, password, context);

  if (response.statusCode == 200) {
    GoRouter.of(context).pushReplacementNamed('home');
  } else {
    Fluttertoast.showToast(msg: response.data['data']);
  }
  return user;
}
