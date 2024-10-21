import 'package:mime_type/mime_type.dart';

String? getMimeType(String? filePath) {
  if (filePath != null) {
    return mime(filePath); // Dapatkan tipe MIME menggunakan mime_type package
  }
  return null;
}
