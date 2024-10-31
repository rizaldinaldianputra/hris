import 'dart:convert';
import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/global_function.dart';

import 'package:hris/riverpod/leave.dart';
import 'package:hris/riverpod/user.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hris/utility/notifikasiwidget.dart';
import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestLeavePage extends ConsumerStatefulWidget {
  const RequestLeavePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestLeavePageState();
}

class _RequestLeavePageState extends ConsumerState<RequestLeavePage> {
  String? selectedValue;
  PlatformFile? selectedFile;
  String? base64String; // Untuk menyimpan hasil konversi Base64
  bool isLoading = false; // Tambahkan variabel ini untuk mengontrol loading
  Notifikasi? notifikasi;
  TextEditingController startdateTimeController = TextEditingController();
  TextEditingController enddateTimeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  String? leavetypeid;

  @override
  void initState() {
    notifikasi = Notifikasi(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider(context));
    final leavePending = ref.watch(leavePendingProvider.notifier);

    return userData.when(
      data: (data) {
        final leaveProvider =
            ref.watch(leaveTypeProvider(context, data!.companyId!));

        return isLoading
            ? const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              )
            : Scaffold(
                appBar: appBarWidget('Leave Request Form'),
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      leaveProvider.when(
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
                            hinttitle: 'Choose Type',
                            selectedValue: selectedValue,
                            title: 'Leave Type',
                            icons: Image.asset('assets/leave/leavetype.png'),
                            onchange: (newValue) {
                              setState(() {
                                selectedValue =
                                    newValue; // Memperbarui selectedValue
                                leavetypeid = leaveTypeMap[
                                    newValue!]; // Mengambil key berdasarkan value yang dipilih
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      dateTimePicker(
                        title: 'Leave Date',
                        hinttitle: 'Start date',
                        controller: startdateTimeController,
                        icons: Image.asset('assets/leave/date.png'),
                        context: context,
                      ),

                      dateTimePicker(
                        title: '',
                        hinttitle: 'End date',
                        controller: enddateTimeController,
                        icons: Image.asset('assets/leave/date.png'),
                        context: context,
                      ),
                      const SizedBox(height: 10),
                      buildReasonField(),
                      const SizedBox(height: 5),
                      buildUploadFileButton(),
                      if (selectedFile != null && selectedFile!.path != null)
                        buildSelectedFileImage(),
                      // Indikator loading
                    ],
                  ),
                ),
                bottomNavigationBar: bootomSubmit(
                  'Submit Request',
                  Image.asset('assets/submit.png'),
                  () => submitLeaveRequest(),
                ),
              );
      },
      error: (object, error) => Scaffold(
        body: Center(child: Text(error.toString())),
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildReasonField() {
    return Column(
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
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: HexColor('#D9D9D9')),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            maxLines: 3,
            controller: reasonController,
            decoration: InputDecoration(
              hintStyle: GoogleFonts.inter(color: HexColor('#B3B3B3')),
              hintText: '(Optional)',
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUploadFileButton() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        height: 40,
        width: 124,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: HexColor('#757575')),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 18, color: HexColor('#757575')),
            const SizedBox(width: 5),
            Text(
              'Upload File',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: HexColor('#757575'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedFileImage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Image.file(
        File(selectedFile!.path!),
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }

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

  void submitLeaveRequest() {
    setState(() {
      isLoading = true; // Set loading menjadi true saat submit
    });

    Map<String, dynamic> buildData() {
      if (base64String != null && selectedFile != null) {
        final mimeType = getMimeType(selectedFile!.path);
        return {
          "startDate": startdateTimeController.text,
          "endDate": enddateTimeController.text,
          "leaveTypeId": leavetypeid,
          "reason": reasonController.text,
          "files": ["data:$mimeType;base64,$base64String"],
        };
      }
      return {}; // Kembalikan map kosong jika tidak ada file yang diupload
    }

    final leaveSaveData = ref.read(leaveSaveDataProvider(context).notifier);
    leaveSaveData
        .saveData(context: context, data: buildData())
        .then((Response response) {
      setState(() {
        isLoading = false; // Set loading menjadi false setelah respons diterima
      });
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

  Widget dateTimePicker({
    required String title,
    required String hinttitle,
    required TextEditingController controller,
    required Widget icons,
    required BuildContext context,
  }) {
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
        Container(
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
                child: icons,
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16),
                    hintText: hinttitle,
                    hintStyle: GoogleFonts.inter(color: HexColor('#B3B3B3')),
                    border: InputBorder.none,
                  ),
                  readOnly: true, // Membuat field hanya bisa dibaca
                  onTap: () async {
                    await _selectDate(
                        controller); // Panggil fungsi untuk memilih tanggal
                  },
                ),
              ),
            ],
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
            // Membuat dropdown melebar sesuai lebar container
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
              contentPadding: const EdgeInsets.only(
                  top: 12, left: 16.0, right: 12, bottom: 12),

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
                  padding: const EdgeInsets.only(left: 20.0),
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
}
