import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hris/config/constant.dart';

import 'package:hris/service/auth_services.dart';
import 'package:go_router/go_router.dart';

doLogin(BuildContext context, String user, String password) async {
  final authService = AuthService(context, user, password);
  if (user == '') {
    Fluttertoast.showToast(
        msg: 'Username Kosong',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13);
    return;
  } else if (password == '') {
    Fluttertoast.showToast(
        msg: 'Password Kosong',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13);
    return;
  }
  int? response = await authService.authenticate(
      '$API_URL/auth/login', user, password, context);
  print(response.toString());
  if (response == 200) {
    context.pushReplacementNamed('home');
  } else {
    Fluttertoast.showToast(
        msg: 'Not Found',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 13);
  }
}
