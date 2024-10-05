import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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

AppBar appBarWidget(String title) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.inter(
          textStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
    ),
    centerTitle: true,
    backgroundColor: HexColor('#01A2E9'),
    iconTheme: const IconThemeData(
      color: Colors.white, // Ubah warna ikon back
    ),
  );
}

AppBar appBarWidgetWithTralling(String title) {
  return AppBar(
    title: Text(
      title,
      style: GoogleFonts.inter(
          textStyle: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white)),
    ),
    centerTitle: true,
    backgroundColor: HexColor('#01A2E9'),
    iconTheme: const IconThemeData(
      color: Colors.white, // Ubah warna ikon back
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Image.asset('assets/filter.png'),
      ),
    ],
  );
}

Widget bootomSubmit(
  String title,
  Widget icon,
  route,
) {
  return GestureDetector(
    onTap: route,
    child: Container(
        margin: const EdgeInsets.all(20),
        height: 50,
        decoration: BoxDecoration(
            color: HexColor('#01A2E9'),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ))),
  );
}
