import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class EmploymentInfoPage extends ConsumerStatefulWidget {
  const EmploymentInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmploymentInfoPageState();
}

TextEditingController usernameController = TextEditingController();
TextEditingController birhtDayController = TextEditingController();

String? selectedValue;
final List<String> items = [
  'Male',
  'Female',
];
DateTime? selectedDateTime;
PlatformFile? selectedFile;

class _EmploymentInfoPageState extends ConsumerState<EmploymentInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Employement Info'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Account Information
              Text(
                'Management Employee Information',
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              //
              inputReadOnly(
                controller: usernameController,
                hint: 'PT. Jasa Raharja',
                title: 'Company',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: 'Digital Development',
                title: 'Department',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: 'IT Support',
                title: 'Position',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: 'Staff',
                title: 'Level',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: '',
                title: 'Shift',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: '',
                title: 'Head',
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Document Info',
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              inputReadOnly(
                controller: usernameController,
                hint: '',
                title: 'Tax Number',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: '',
                title: 'Tax Registered Name',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: '',
                title: 'Document Identity Number',
              ),
              dropdownIcon(
                hinttitle: 'Seumur Hidup',
                selectedValue: selectedValue,
                listiem: items,
                title: 'Document Identity Expiry',
              ),

              dateTimePicker('Document Identity Expiry', '07 December 1992',
                  birhtDayController, Image.asset('assets/leave/date.png')),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Document Identity File',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  height: 40,
                  width: 149,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: HexColor('#757575'))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 18,
                        color: HexColor('#757575'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Upload Image',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: HexColor('#757575'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              if (selectedFile != null && selectedFile!.path != null)
                Image.file(
                  File(selectedFile!.path!), // Menampilkan file gambar
                  height: 150, // Atur tinggi gambar sesuai kebutuhan
                  width: 150, // Atur lebar gambar sesuai kebutuhan
                  fit: BoxFit.cover, // Mengatur cara gambar diubah ukurannya
                ),
              inputReadOnly(
                controller: usernameController,
                hint: '10992320012399',
                title: 'Document Identity Number',
              ),
              inputReadOnly(
                controller: usernameController,
                hint: 'Jane Doe',
                title: 'Document BPJS-TK Name',
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Document BPJS-TK File',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  height: 40,
                  width: 149,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: HexColor('#757575'))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 18,
                        color: HexColor('#757575'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Upload Image',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: HexColor('#757575'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              if (selectedFile != null && selectedFile!.path != null)
                Image.file(
                  File(selectedFile!.path!), // Menampilkan file gambar
                  height: 150, // Atur tinggi gambar sesuai kebutuhan
                  width: 150, // Atur lebar gambar sesuai kebutuhan
                  fit: BoxFit.cover, // Mengatur cara gambar diubah ukurannya
                ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Contract Info',
                style: GoogleFonts.inter(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: HexColor('#EAEAEA'))),
                child: Column(
                  children: [
                    ListTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Status Employee',
                                    style: GoogleFonts.inter(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 80,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      color: HexColor('#2A4DDB'),
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Contract',
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    )),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.navigate_next,
                                color: HexColor('#3699FF'),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Container(
                                child: const Column(
                                  children: [
                                    Text('Start Date'),
                                    Text('20 Jan 2023')
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Container(
                                child: const Column(
                                  children: [
                                    Text('Start Date'),
                                    Text('20 Jan 2023')
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bootomSubmit(
        'Save',
        Container(),
        () => context.goNamed('home'),
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
