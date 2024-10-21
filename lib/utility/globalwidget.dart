import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

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

AppBar appBarWidgetWithTralling(String title, Widget action) {
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
        child: action,
      ),
    ],
    toolbarHeight: 56,
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

Widget inputReadOnly(
    {required String title,
    required TextEditingController controller,
    required String hint}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: TextField(
            readOnly: true,
            controller: controller,
            decoration: InputDecoration(
              fillColor:
                  Colors.grey.shade50, // Warna latar belakang ketika readOnly
              filled: true,
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Sudut membulat
                borderSide: BorderSide(
                    color: HexColor('#D9D9D9'), width: 1), // Border biru
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: HexColor('#D9D9D9'), width: 1), // Border saat aktif
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: HexColor('#D9D9D9'), width: 2), // Border saat fokus
              ),

              // Padding di dalam TextField
            ),
          ),
        ),
      ],
    ),
  );
}

Widget inputWidget(
    {required String title,
    required TextEditingController controller,
    required String hint,
    required Widget iconWidget}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
                color: HexColor('#D9D9D9'), width: 1), // Border di semua sisi
            borderRadius: BorderRadius.circular(8.0), // Sudut membulat
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(12), // Sesuaikan tinggi ikon
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        color: HexColor('#D9D9D9'),
                        width: 1 // Border kanan pada ikon
                        ),
                  ),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(8.0),
                  ),
                ),
                child: SizedBox(height: 20, width: 20, child: iconWidget),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10, // Padding di dalam TextField
                    ),
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder
                        .none, // Menghapus border default dari TextField
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget inputText(
    {required String title,
    required TextEditingController controller,
    required String hint}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 50,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              // Warna latar belakang ketika readOnly
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0), // Sudut membulat
                borderSide: BorderSide(
                    color: HexColor('#D9D9D9'), width: 1), // Border biru
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: HexColor('#D9D9D9'), width: 1), // Border saat aktif
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                    color: HexColor('#D9D9D9'), width: 2), // Border saat fokus
              ),

              // Padding di dalam TextField
            ),
          ),
        ),
      ],
    ),
  );
}
