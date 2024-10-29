import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mime_type/mime_type.dart';

String? getMimeType(String? filePath) {
  if (filePath != null) {
    return mime(filePath); // Dapatkan tipe MIME menggunakan mime_type package
  }
  return null;
}

Future<String?> convertXFileToBase64(XFile imageFile) async {
  final bytes = await imageFile.readAsBytes();
  return base64Encode(bytes);
}

String convertTimeOfDayToString(TimeOfDay? time) {
  // Mengembalikan "null" jika time bernilai null
  if (time == null) return 'null';

  // Mengonversi TimeOfDay menjadi string waktu "HH:mm"
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}
