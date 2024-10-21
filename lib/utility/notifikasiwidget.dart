import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Notifikasi {
  final BuildContext context;
  late FToast fToast;

  Notifikasi(this.context) {
    fToast = FToast();
    fToast.init(context);
  }

  // Notifikasi sukses
  void showSuccessToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.greenAccent,
      ),
      child: ListTile(
        leading: const Icon(Icons.error, color: Colors.white),
        title: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }

  // Notifikasi error
  void showErrorToast(String message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
      ),
      child: ListTile(
        leading: const Icon(Icons.error, color: Colors.white),
        title: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }
}
