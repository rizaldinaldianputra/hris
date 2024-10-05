import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestOvertime extends ConsumerStatefulWidget {
  const RequestOvertime({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestOvertimeState();
}

class _RequestOvertimeState extends ConsumerState<RequestOvertime> {
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

  TextEditingController overtimeController = TextEditingController();
  TextEditingController overtimeStartController = TextEditingController();
  TextEditingController overtimeEndController = TextEditingController();
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Overtime Request Form'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dateTimePicker('Overtime Date', 'Choose date', overtimeController,
                Image.asset('assets/leave/date.png')),
            dropdownIcon(
                listiem: items,
                hinttitle: 'Choose Shift',
                selectedValue: selectedValue,
                title: 'Overtime Shift',
                icons: Image.asset('assets/overtime/overtimeshift.png')),
            dateTimePicker(
                'Start Shift (start date & time)',
                'Choose Duration',
                overtimeStartController,
                Image.asset('assets/overtime/clock.png')),
            dateTimePicker(
                'End Shift (end date & time)',
                'Choose Duration',
                overtimeEndController,
                Image.asset('assets/overtime/clock.png')),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Compensation',
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
                      readOnly: true,
                      decoration: InputDecoration(
                        filled: true, // Mengaktifkan fill color

                        fillColor: HexColor('#F1F1F1'),
                        hintStyle:
                            GoogleFonts.inter(color: HexColor('#B3B3B3')),
                        hintText: 'Paid Overtime', // Placeholder text
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Work note',
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

  Widget dateTimePicker(String title, String hinttitle,
      TextEditingController controller, Widget icons) {
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

  Widget dropdownIcon(
      {required String title,
      required selectedValue,
      required String hinttitle,
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
              hint: Padding(
                padding: const EdgeInsets.only(left: 22.0),
                child: Text(
                  hinttitle,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: HexColor('#B3B3B3')),
                ),
              ),
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
