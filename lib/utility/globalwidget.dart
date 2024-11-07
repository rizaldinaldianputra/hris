import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/status_color.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:hris/service/common_services.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';
import 'package:shimmer/shimmer.dart';

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

Widget shimmerLoadingCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
    ),
  );
}

Widget dataNotFound(String title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(
        height: 100,
      ),
      Image.asset('assets/notfound.png'),
      const SizedBox(
        height: 16,
      ),
      Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black),
      ),
    ],
  );
}

statusWidget(String data) {
  return Container(
    padding: const EdgeInsets.only(right: 12, left: 12, top: 6, bottom: 6),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      color: statusColor(data),
    ),
    child: Text(
      data,
      style: GoogleFonts.inter(
        textStyle: TextStyle(
            color: statusColorText(data),
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ),
    ),
  );
}

Widget dropdownMonth(TextEditingController controller, BuildContext context,
    List<DropdownModel> list) {
  String selectedValue = '';
  int selectedIndex = 0;

  return Expanded(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: HexColor('#D9D9D9'), width: 1),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: HexColor('#D9D9D9'), width: 1),
              ),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return SizedBox(
                          height: 350,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
                                Container(
                                  height: 6,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: HexColor('#EAEBEB'),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(200)),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                const Text(
                                  'Choose Month',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 120,
                                  height: 170,
                                  child: ListWheelScrollView.useDelegate(
                                    itemExtent: 70,
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        selectedIndex = index;
                                        selectedValue =
                                            list[index].value.toString();
                                      });
                                    },
                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      builder: (context, index) {
                                        bool isSelected =
                                            index == selectedIndex;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex = index;
                                              selectedValue =
                                                  list[index].value.toString();
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  list[index].value.toString(),
                                                  style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: isSelected
                                                        ? Colors.black
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              const Divider(
                                                  color: Colors.black),
                                            ],
                                          ),
                                        );
                                      },
                                      childCount: list.length,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    controller.text = selectedValue;
                                    Navigator.of(context).pop(); // Tutup modal
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: HexColor('#01A2E9'),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                    ),
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(16),
                                    height: 48,
                                    child: Center(
                                      child: Text(
                                        'View',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
              readOnly: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    top: 12, left: 16, right: 16, bottom: 12),
                hintText: 'Choice Month',
                suffixIcon: const Icon(Icons.arrow_drop_down),
                hintStyle: GoogleFonts.inter(color: HexColor('#B3B3B3')),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
