import 'dart:convert';
import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/global_function.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/riverpod/overtime.dart';
import 'package:hris/riverpod/session.dart';
import 'package:hris/riverpod/user.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hris/utility/notifikasiwidget.dart';
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
    var status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        selectedFile = result.files.single;

        if (selectedFile!.size <= 3 * 1024 * 1024) {
          final bytes = await File(selectedFile!.path!).readAsBytes();
          setState(() {
            base64String = base64Encode(bytes); // Mengonversi bytes ke Base64
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File size exceeds 3 MB')),
          );
        }
      }
    } else {
      _handlePermissionDenied(status);
    }
  }

  void _handlePermissionDenied(PermissionStatus status) {
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    } else if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Storage permission permanently denied. Please enable it in settings.'),
        ),
      );
      openAppSettings();
    }
  }

  TextEditingController overtimeController = TextEditingController();
  TextEditingController overtimeStartController = TextEditingController();
  TextEditingController overtimeEndController = TextEditingController();
  DateTime? selectedDateTime;

  String? overtimetypeid;

  bool isLoading = false;

  String? base64String;

  Notifikasi? notifikasi;

  TextEditingController workNoteController = TextEditingController();

  @override
  void initState() {
    notifikasi = Notifikasi(context);
    _loadUserData();
    super.initState();
  }

  UserModel? _user; // Variabel untuk menyimpan data user

  Future<void> _loadUserData() async {
    final user = await UserPreferences.getUser();
    setState(() {
      _user = user; // Update state dengan data user
    });
  }

  @override
  Widget build(BuildContext context) {
    final overtimeProvider =
        ref.watch(overtimeTypeProvider(context, _user?.companyId ?? ''));
    return isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: appBarWidget('Overtime Request Form'),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overtime Date',
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
                                color: HexColor('#D9D9D9'), width: 1),
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
                                    right: BorderSide(
                                        color: HexColor('#D9D9D9'), width: 1),
                                  ),
                                ),
                                child: Image.asset('assets/leave/date.png'),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: overtimeController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 16),
                                    hintText: 'Choose date',
                                    hintStyle: GoogleFonts.inter(
                                        color: HexColor('#B3B3B3')),
                                    border: InputBorder.none,
                                  ),
                                  readOnly:
                                      true, // Membuat field hanya bisa dibaca
                                  onTap: () async {
                                    await _selectDate(
                                        overtimeController); // Panggil fungsi untuk memilih tanggal
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    overtimeProvider.when(
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) => Text(error.toString()),
                      data: (data) {
                        List<String> value = [];
                        Map<String, String> leaveTypeMap = {};

                        for (var element in data) {
                          value.add(element.value ?? '');
                          leaveTypeMap[element.value ?? ''] = element.key ??
                              ''; // Menyimpan key untuk setiap value
                        }

                        return dropdownIcon(
                          listiem: value,
                          hinttitle: 'Choose Shift',
                          selectedValue: selectedValue,
                          title: 'Overtime Shift',
                          icons:
                              Image.asset('assets/overtime/overtimeshift.png'),
                          onchange: (newValue) {
                            setState(() {
                              selectedValue =
                                  newValue; // Memperbarui selectedValue
                              overtimetypeid = leaveTypeMap[
                                  newValue!]; // Mengambil key berdasarkan value yang dipilih
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    dateTimePicker(
                        'Start Shift (start date & time)',
                        'Choose Duration',
                        overtimeStartController,
                        Image.asset('assets/overtime/clock.png')),
                    const SizedBox(
                      height: 20,
                    ),
                    dateTimePicker(
                        'End Shift (end date & time)',
                        'Choose Duration',
                        overtimeEndController,
                        Image.asset('assets/overtime/clock.png')),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
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
                            borderRadius: BorderRadius.circular(
                                10), // Mengatur sudut border
                          ),
                          child: TextField(
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true, // Mengaktifkan fill color

                              fillColor: HexColor('#F1F1F1'),
                              hintStyle:
                                  GoogleFonts.inter(color: HexColor('#B3B3B3')),
                              hintText: 'Paid Overtime', // Placeholder text
                              border: InputBorder
                                  .none, // Menghilangkan border default
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 8.0), // Padding di dalam TextField
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
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
                            borderRadius: BorderRadius.circular(
                                10), // Mengatur sudut border
                          ),
                          child: TextField(
                            maxLines: 3, // Membatasi maksimum 3 baris
                            controller: workNoteController,
                            decoration: InputDecoration(
                              hintStyle:
                                  GoogleFonts.inter(color: HexColor('#B3B3B3')),
                              hintText: '(Optional)', // Placeholder text
                              border: InputBorder
                                  .none, // Menghilangkan border default
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
                          fit: BoxFit
                              .cover, // Mengatur cara gambar diubah ukurannya
                        ),
                      ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: bootomSubmit(
              'Submit Request',
              Image.asset('assets/submit.png'),
              () => submitOvertimeRequest(),
            ),
          );
  }

  Widget dateTimePicker(String title, String hinttitle,
      TextEditingController controller, Widget icons) {
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
                initialTime:
                    TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
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
                  padding: const EdgeInsets.only(left: 16.0),
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: HexColor('#757575'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget dropdownIcon(
      {required String title,
      required selectedValue,
      required List listiem,
      required String hinttitle,
      required Widget icons,
      required Function onchange}) {
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
            isExpanded: true,
            icon: const Padding(
              padding: EdgeInsets.all(8.0), // Berikan padding di sini
              child: Icon(Icons.arrow_drop_down), // Ikon dropdown
            ),
            hint: Padding(
              padding: const EdgeInsets.only(left: 16.0),
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
                  padding: const EdgeInsets.only(top: 3, left: 16.0),
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
                onchange(value); // Panggil fungsi onchange dengan nilai baru
              });
            },
          ),
        ),
      ],
    );
  }

  void submitOvertimeRequest() {
    setState(() {
      isLoading = true; // Set loading menjadi true saat submit
    });

    Map<String, dynamic> buildData() {
      if (base64String != null && selectedFile != null) {
        final mimeType = getMimeType(selectedFile!.path);
        return {
          "startShiftDateTime": overtimeStartController.text,
          "endShiftDateTime": overtimeEndController.text,
          "overtimeShiftRequestId": overtimetypeid,
          "workNote": workNoteController.text,
          "files": ["data:$mimeType;base64,$base64String"],
        };
      }
      return {}; // Kembalikan map kosong jika tidak ada file yang diupload
    }

    final overtimeSaveData =
        ref.read(overtimeSaveDataProvider(context).notifier);

    overtimeSaveData
        .saveData(context: context, data: buildData())
        .then((Response response) {
      setState(() {
        isLoading = false; // Set loading menjadi false setelah respons diterima
      });

      // Memastikan 'message' ada dalam respons
      final message = response.data['message'];

      if (response.statusCode == 200) {
        notifikasi!.showSuccessToast(message);
        context.goNamed('home');
      } else {
        notifikasi!.showErrorToast(
            message); // Menggunakan showErrorToast untuk kesalahan
      }
    }).catchError((error) {
      setState(() {
        isLoading = false; // Set loading menjadi false jika ada error
      });
      notifikasi!.showErrorToast('Error: $error'); // Menampilkan kesalahan
    });
  }

  Future<void> _selectDate(TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(pickedDate); // Format tanggal
      controller.text = formattedDate; // Atur nilai controller
    }
  }
}
