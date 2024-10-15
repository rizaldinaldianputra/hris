import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scroll_wheel_date_picker/scroll_wheel_date_picker.dart';

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
  PlatformFile? selectedFile;

  DateTime? selectedDateTime; // Mengubah menjadi PlatformFile

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

  TextEditingController dateTimeController = TextEditingController();
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
                hinttitle: 'Choose Type',
                selectedValue: selectedValue,
                title: 'Leave Type',
                icons: Image.asset('assets/leave/leavetype.png')),
            dateTimePicker('Leave Date', 'Choose date', dateTimeController,
                Image.asset('assets/leave/date.png')),
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

  Widget dateTimePicker(String title, String hinttitle,
      TextEditingController controller, Widget icons) {
    DateTime selectedDate = DateTime.now();
    final DateTime startDate = DateTime(2000); // Tanggal awal
    final DateTime lastDate = DateTime(DateTime.now().year, 12, 31);
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
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(0),
                    height: 350,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 6,
                            width: 40,
                            decoration: BoxDecoration(
                                color: HexColor('#EAEBEB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(200))),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 196,
                            height: 164,
                            child: ScrollWheelDatePicker(
                              theme: FlatDatePickerTheme(
                                backgroundColor: Colors.white,
                                overlay: ScrollWheelDatePickerOverlay.holo,
                                overAndUnderCenterOpacity: 0.2,
                                itemTextStyle: defaultItemTextStyle.copyWith(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: HexColor('#333333')),
                                overlayColor: HexColor('#757575'),
                              ),
                              startDate: startDate, // Set tanggal awal
                              lastDate:
                                  lastDate, // Set batas maksimal ke tahun saat ini
                              initialDate:
                                  selectedDate, // Tanggal awal yang sudah divalidasi
                              onSelectedItemChanged: (DateTime newDate) {},
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Menutup Bottom Sheet
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor('#01A2E9'),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                width: double.infinity,
                                margin: const EdgeInsets.all(16),
                                height: 48,
                                child: Center(
                                    child: Text(
                                  'Next',
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ))),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
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
                  Text(
                    selectedDateTime != null
                        ? "${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} ${selectedDateTime!.hour}:${selectedDateTime!.minute}"
                        : hinttitle,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: selectedDateTime != null
                          ? Colors.black
                          : HexColor('#B3B3B3'),
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
      required List listiem,
      required String hinttitle,
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
                padding: const EdgeInsets.only(left: 20.0),
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
