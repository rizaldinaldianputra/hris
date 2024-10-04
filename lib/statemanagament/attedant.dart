import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attedant.g.dart';

@riverpod
class XFileNotifier extends _$XFileNotifier {
  @override
  XFile? build() {
    return null; // Nilai awal, belum ada file yang disimpan
  }

  // Fungsi untuk menyimpan XFile
  void saveFile(XFile file) {
    print(
        "File saved: ${file.path}"); // Log untuk memeriksa apakah file disimpan
    state = file;
  }

  // Fungsi untuk menghapus file (set ke null)
  void clearFile() {
    state = null;
  }

  // Fungsi untuk mendapatkan byte array dari XFile
  Future<Uint8List?> getFileBytes() async {
    if (state != null) {
      try {
        return await state!.readAsBytes(); // Membaca file sebagai byte array
      } catch (e) {
        print("Error membaca file: $e");
        return null;
      }
    }
    return null; // Jika tidak ada file, kembalikan null
  }
}
