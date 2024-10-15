import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'langguage.g.dart'; // Pastikan nama file ini sesuai

@riverpod
class LanguageNotifier extends _$LanguageNotifier {
  @override
  Locale build() {
    return const Locale('en'); // Bahasa default
  }

  void changeLanguage(String languageCode) {
    state = Locale(languageCode);
  }
}
