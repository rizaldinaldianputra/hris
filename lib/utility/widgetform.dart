import 'package:flutter/material.dart';

Widget inputData() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Warna border
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.grey, // Warna border saat tidak fokus
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.blue, // Warna border saat fokus
          ),
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.all(8.0), // Padding di dalam prefix
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1), // Warna background prefix
            borderRadius: BorderRadius.circular(8.0), // Membuat sudut bulat
          ),
          child: const Icon(Icons.search, color: Colors.blue), // Ikon di prefix
        ),
        hintText: 'hintText',
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    ),
  );
}
