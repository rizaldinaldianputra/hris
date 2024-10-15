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

class FamilyEditPage extends ConsumerStatefulWidget {
  const FamilyEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FamilyEditPageState();
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

class _FamilyEditPageState extends ConsumerState<FamilyEditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidgetWithTralling('Edit Family', const Icon(Icons.check)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              inputText(
                controller: usernameController,
                hint: 'Sutan Sahir',
                title: 'Name',
              ),
              dropdownIcon(
                hinttitle: 'Seumur Hidup',
                selectedValue: selectedValue,
                listiem: items,
                title: 'Family Relation',
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.zero, // Hilangkan padding default ListTile
                      title: const Text(
                        'Laki-laki',
                        style:
                            TextStyle(fontSize: 12), // Ukuran teks lebih kecil
                      ),
                      leading: Radio<String>(
                        value: 'Laki-laki',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        visualDensity:
                            VisualDensity.compact, // Radio lebih kecil
                        materialTapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Perkecil tap target
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.zero, // Hilangkan padding default ListTile
                      title: const Text(
                        'Perempuan',
                        style:
                            TextStyle(fontSize: 12), // Ukuran teks lebih kecil
                      ),
                      leading: Radio<String>(
                        value: 'Perempuan',
                        groupValue: _selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                        visualDensity:
                            VisualDensity.compact, // Radio lebih kecil
                        materialTapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Perkecil tap target
                      ),
                    ),
                  ),
                ],
              ),
              dateTimePicker('Birth Date', '07 December 1992',
                  birhtDayController, Image.asset('assets/leave/date.png')),
              const SizedBox(
                height: 8,
              ),
              inputText(
                controller: usernameController,
                hint: 'Washington',
                title: 'Birth Place',
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Address',
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
                    hintText: 'Address',
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
              const Text(
                'Photos',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  (selectedFile != null && selectedFile!.path != null)
                      ? Image.file(
                          File(selectedFile!.path!), // Menampilkan file gambar
                          height: 150, // Atur tinggi gambar sesuai kebutuhan
                          width: 150, // Atur lebar gambar sesuai kebutuhan
                          fit: BoxFit
                              .cover, // Mengatur cara gambar diubah ukurannya
                        )
                      : Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/profile.png'), // Ganti dengan path gambar Anda
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  const SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: _pickFile,
                    child: Container(
                      height: 38,
                      width: 128,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                          color: HexColor('#757575'),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Change Photos',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: HexColor('#757575')),
                        ),
                      ),
                    ),
                  )
                ],
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
