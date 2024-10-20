import 'dart:convert';
import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/models/leave_model.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/statemanagament/leave.dart';
import 'package:hris/statemanagament/user.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
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
        selectedFile = result.files.single; // Ambil file yang dipilih

        // Periksa ukuran file
        if (selectedFile!.size <= 3 * 1024 * 1024) {
          // Cek jika ukuran file <= 3MB
          // Baca file dan konversi ke Base64
          final bytes = await File(selectedFile!.path!).readAsBytes();
          setState(() {
            base64String = base64Encode(bytes); // Mengonversi bytes ke Base64
          });
        } else {
          // Tampilkan pesan jika ukuran file melebihi 3MB
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File size exceeds 3 MB')),
          );
        }
      }
    } else if (status.isDenied) {
      // Jika izin ditolak
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    } else if (status.isPermanentlyDenied) {
      // Jika izin ditolak secara permanen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Storage permission permanently denied. Please enable it in settings.'),
        ),
      );
      // Tampilkan dialog untuk mengarahkan pengguna ke pengaturan
      openAppSettings();
    }
  }

  TextEditingController startdateTimeController = TextEditingController();
  TextEditingController enddateTimeController = TextEditingController();

  String? leavetypeid;

  TextEditingController reasonController = TextEditingController();

  String? base64String; // Untuk menyimpan hasil konversi Base64

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider(context));
    return userData.when(
      data: (data) {
        final attedantProvider =
            ref.watch(LeaveTypeProvider(context, data!.companyId!));

        return Scaffold(
          appBar: appBarWidget('Leave Request Form'),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                attedantProvider.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stackTrace) => Text(error.toString()),
                    data: (data) {
                      List<String> value = [];
                      for (var element in data) {
                        value.add(element.value);
                        leavetypeid = element.key;
                      }
                      return dropdownIcon(
                          listiem: value,
                          hinttitle: 'Choose Type',
                          selectedValue: selectedValue,
                          title: 'Leave Type',
                          icons: Image.asset('assets/leave/leavetype.png'));
                    }),
                dateTimePicker(
                    'Leave Date',
                    'Start date',
                    startdateTimeController,
                    Image.asset('assets/leave/date.png'),
                    context),
                dateTimePicker('Leave Date', 'End date', enddateTimeController,
                    Image.asset('assets/leave/date.png'), context),
                const SizedBox(
                  height: 10,
                ),
                Column(
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
                        controller: reasonController,
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
                      fit:
                          BoxFit.cover, // Mengatur cara gambar diubah ukurannya
                    ),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: bootomSubmit(
            'Submit Request',
            Image.asset('assets/submit.png'),
            () {
              Map<String, dynamic> buildData() {
                if (base64String != null && selectedFile != null) {
                  final mimeType = getMimeType(selectedFile!.path);
                  return {
                    "startDate": startdateTimeController.text,
                    "endDate": enddateTimeController.text,
                    "leaveTypeId": leavetypeid,
                    "reason": reasonController.text,
                    "files": [
                      "data:$mimeType;base64,$base64String" // Tambahkan MIME type ke dalam string Base64
                    ]
                  };
                }
                return {}; // Kembalikan map kosong jika tidak ada file yang diupload
              }

              ref
                  .watch(leaveSaveDataProvider(context).notifier)
                  .saveData(context: context, data: data);
            },
          ),
        );
      },
      error: (object, error) => Scaffold(
        body: Center(
          child: Text(error.toString()),
        ),
      ),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  String? getMimeType(String? filePath) {
    if (filePath != null) {
      return mime(filePath); // Dapatkan tipe MIME menggunakan mime_type package
    }
    return null;
  }

  Widget dateTimePicker(String title, String hinttitle,
      TextEditingController controller, Widget icons, BuildContext context) {
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
                  child: SizedBox(height: 20, width: 20, child: icons),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: true, // Membuat TextField hanya bisa dibaca
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, // Padding di dalam TextField
                      ),
                      hintText: hinttitle,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder
                          .none, // Menghapus border default dari TextField
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDatePickerMode: DatePickerMode.day,
                        initialDate: selectedDateTime ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        selectedDateTime =
                            pickedDate; // Update selectedDateTime
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        controller.text =
                            formattedDate; // Set output date to TextField value.
                      }
                    },
                  ),
                ),
              ],
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
    return Column(
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
            isExpanded: true, // Membuat dropdown melebar sesuai lebar container
            hint: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                hinttitle,
                maxLines: 2, // Membatasi teks maksimal 2 baris
                overflow:
                    TextOverflow.ellipsis, // Memotong teks jika terlalu panjang
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
                  child: Text(
                    item,
                    maxLines: 2, // Membatasi teks maksimal 2 baris
                    overflow: TextOverflow
                        .ellipsis, // Memotong teks jika terlalu panjang
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
