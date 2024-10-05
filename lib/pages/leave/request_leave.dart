import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestLeavePage extends ConsumerStatefulWidget {
  const RequestLeavePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestLeavePageState();
}

class _RequestLeavePageState extends ConsumerState<RequestLeavePage> {
  String? selectedValue;
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  PlatformFile? selectedFile; // Mengubah menjadi PlatformFile

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Leave Request Form'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dropdownIcon(
                listiem: items,
                selectedValue: selectedValue,
                title: 'Leave Type',
                icons: Image.asset('assets/leave/leavetype.png')),
            dropdownIcon(
                listiem: items,
                selectedValue: selectedValue,
                title: 'Leave Date',
                icons: Image.asset('assets/leave/leavedate.png')),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reason',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: HexColor(
                              '#D9D9D9')), // Mengatur border untuk keseluruhan
                      borderRadius:
                          BorderRadius.circular(10), // Mengatur sudut border
                    ),
                    child: TextField(
                      maxLines: 3, // Membatasi maksimum 3 baris
                      decoration: InputDecoration(
                        hintStyle:
                            GoogleFonts.inter(color: HexColor('#B3B3B3')),
                        hintText: '(Optional)', // Placeholder text
                        border:
                            InputBorder.none, // Menghilangkan border default
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0), // Padding di dalam TextField
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: _pickFile,
              child: Container(
                height: 40,
                width: 124,
                margin: const EdgeInsets.all(10.0),
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
                      'Upload File',
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
            // Tampilkan gambar yang dipilih
            if (selectedFile != null && selectedFile!.path != null)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.file(
                  File(selectedFile!.path!), // Menampilkan file gambar
                  height: 150, // Atur tinggi gambar sesuai kebutuhan
                  width: 150, // Atur lebar gambar sesuai kebutuhan
                  fit: BoxFit.cover, // Mengatur cara gambar diubah ukurannya
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: bootomSubmit(
        'Submit Request',
        Image.asset('assets/submit.png'),
        () => context.goNamed('home'),
      ),
    );
  }

  Widget dropdownIcon(
      {required String title,
      required selectedValue,
      required List listiem,
      required Widget icons}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      HexColor('#D9D9D9')), // Mengatur border untuk keseluruhan
              borderRadius: BorderRadius.circular(10), // Mengatur sudut border
            ),
            child: DropdownButtonFormField<String>(
              value: selectedValue,
              decoration: InputDecoration(
                border: InputBorder.none, // Menghilangkan border default
                prefixIcon: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          color: HexColor(
                              '#D9D9D9')), // Border di sebelah kanan ikon
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icons,
                  ),
                ),
              ),
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
            ),
          )
        ],
      ),
    );
  }
}
