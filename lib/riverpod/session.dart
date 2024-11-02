import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hris/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hris/models/user_model.dart'; // Ganti dengan path model Users Anda

class UserPreferences {
  // Menyimpan data Users ke SharedPreferences
  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  static Future<void> loadAndSaveUser(BuildContext context) async {
    final userService = UserService(context);
    final user = await userService.findUser();

    // Konversi objek Users ke JSON string dan simpan ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson()); // Konversi ke JSON
    await prefs.setString('user', userJson);
  }

  // Memuat data Users dari SharedPreferences
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  // Menghapus data Users dari SharedPreferences (jika diperlukan)
  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
