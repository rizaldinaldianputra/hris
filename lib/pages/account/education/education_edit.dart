import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class EducationEditPage extends ConsumerStatefulWidget {
  const EducationEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EducationEditPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController birhtDayController = TextEditingController();

String? selectedValue;
final List<String> items = [
  'Uncle',
  'Father',
];
DateTime? selectedDateTime;
PlatformFile? selectedFile;
String? _selectedGender = 'Laki-laki';

class _EducationEditPageState extends ConsumerState<EducationEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarWidgetWithTralling('Edit Education', const Icon(Icons.check)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                '*Required field',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  color: HexColor('#878787'),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              inputText(
                controller: usernameController,
                hint: 'Universitas Gadjah Mada',
                title: 'University*',
              ),
              dropdownIcon(
                  title: 'Title',
                  selectedValue: selectedValue,
                  listiem: items,
                  hinttitle: 'Master’s Degree'),
              dropdownIcon(
                  title: 'Field of Study',
                  selectedValue: selectedValue,
                  listiem: items,
                  hinttitle: 'Digital Innovation'),
              dateTimePicker('Start Date', '07 December 1992',
                  birhtDayController, Image.asset('assets/leave/date.png')),
              dateTimePicker('End Date Date', '07 December 1992',
                  birhtDayController, Image.asset('assets/leave/date.png')),
              inputText(
                controller: usernameController,
                hint: '3.8',
                title: 'Mark*',
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Activities and Social Event',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 14),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 112,
                child: TextField(
                  maxLines: 3,
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: '...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Sudut membulat
                      borderSide: BorderSide(
                        color: HexColor('#D9D9D9'),
                        width: 1, // Border biru
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: HexColor('#D9D9D9'),
                        width: 1, // Border saat aktif
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: HexColor('#D9D9D9'),
                        width: 2, // Border saat fokus
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Skill',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                'It is better to add the 5 most used in this position. It will also be displayed in the Skills section.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  context.goNamed('educationadd');
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: HexColor('#3699FF'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Add Skill',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: HexColor('#3699FF')),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dateTimePicker(String title, String hinttitle,
      TextEditingController controller, Widget icons) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              // Menampilkan pemilih tanggal
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDateTime ?? DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                // Menampilkan pemilih waktu
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(
                      selectedDateTime ?? DateTime.now()),
                );

                if (pickedTime != null) {
                  // Menggabungkan tanggal dan waktu yang dipilih
                  DateTime newDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                  setState(() {
                    selectedDateTime =
                        newDateTime; // Simpan tanggal/waktu yang dipilih

                    controller.text = DateFormat('yyyy-MM-dd HH:mm')
                        .format(selectedDateTime!); // Simpan ke controller
                  });
                }
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: HexColor('#D9D9D9')),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                            color: HexColor(
                                '#D9D9D9')), // Border di sebelah kanan ikon
                      ),
                    ),
                    child: icons,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      controller.text ?? hinttitle,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: selectedDateTime != null
                            ? Colors.black
                            : HexColor('#B3B3B3'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: HexColor('#757575'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dropdownIcon({
    required String title,
    required selectedValue,
    required List listiem,
    required String hinttitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      HexColor('#D9D9D9')), // Mengatur border untuk keseluruhan
              borderRadius: BorderRadius.circular(10), // Mengatur sudut border
            ),
            child: DropdownButtonFormField<String>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  hinttitle,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: HexColor('#B3B3B3'),
                  ),
                ),
              ),
              value: selectedValue,
              items: listiem.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 20.0),
                    child: Text(item),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none, // Menghilangkan border default
                enabledBorder:
                    InputBorder.none, // Menghilangkan border saat aktif
                focusedBorder:
                    InputBorder.none, // Menghilangkan border saat fokus
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    // Meminta izin akses penyimpanan
    var status = await Permission.storage.request();

    // Cek status izin
    if (status.isGranted) {
      // Jika izin diberikan, pilih file
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          selectedFile = result.files.single; // Ambil file yang dipilih
        });
      }
    } else if (status.isDenied) {
      // Jika izin ditolak
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    } else if (status.isPermanentlyDenied) {
      // Jika izin ditolak secara permanen, minta pengguna untuk mengatur izin di pengaturan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Storage permission permanently denied. Please enable it in settings.')),
      );
      // Tampilkan dialog untuk mengarahkan pengguna ke pengaturan
      openAppSettings();
    }
  }
}
