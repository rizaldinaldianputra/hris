// lib/service/auth_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hris/config/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String username, String password) async {
    const String url = '$API_URL/auth/login';

    try {
      final response = await _dio.post(url,
          data: jsonEncode({
            'username': username,
            'password': password,
          }));

      // Jika respons sukses, simpan token ke SharedPreferences
      final token = response.data['data']['token'];
      print(token);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('token'); // Ganti sesuai dengan struktur respons Anda

      return {
        'success': true,
        'data': response.data,
        'statusCode': response.statusCode,
      };
    } on DioException catch (e) {
      // Jika terjadi error, kembalikan pesan kesalahan
      return {
        'success': false,
        'message': e.response?.data['message'] ?? 'Terjadi kesalahan',
        'statusCode': e.response?.statusCode,
      };
    }
  }
}
