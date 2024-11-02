import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/global_function.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/expenses_model.dart';
import 'package:hris/models/reimbursement%20_expense_model.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/riverpod/reimbusment.dart';
import 'package:hris/riverpod/session.dart';
import 'package:hris/riverpod/user.dart';
import 'package:hris/service/reimburstment_service.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hris/utility/notifikasiwidget.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestRebursement extends ConsumerStatefulWidget {
  const RequestRebursement({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestRebursementState();
}

class _RequestRebursementState extends ConsumerState<RequestRebursement> {
  DropdownModel? selectedValue;
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  PlatformFile? selectedFile; // Mengubah menjadi PlatformFile

  TextEditingController rebursementController = TextEditingController();

  final TextEditingController _expenseAmountController =
      TextEditingController();
  DateTime? selectedDateTime;
  bool isLoading = false;
  String? selectedValueType;
  List<DropdownModel> listDropdown = [];

  String base64String = '';

  Notifikasi? notifikasi;
  List<ExpensesModel> selectExpense = [];

  String keyexpnse = '';

  String? reimbusmenttypeid;

  late ReimburstmentService reimburstmentService;

  DropdownModel selectDropdown = DropdownModel.blank();
  @override
  void initState() {
    notifikasi = Notifikasi(context);
    reimburstmentService = ReimburstmentService(context);
    getAllDropdownTypeExpense();
    _loadUserData();
    super.initState();
  }

  void getAllDropdownTypeExpense() async {
    final listresponse = await reimburstmentService.expenseType();

    setState(() {
      if (listresponse.isNotEmpty) {
        selectDropdown = listresponse.first;
      }
      listDropdown.addAll(listresponse);
    });
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
    final expensesList = ref.watch(reimbursementExpenseNotifierProvider);
    final imageList = ref.watch(reimbursementImageProvider);

    final reimbusmentProvider =
        ref.watch(reimbusmentTypeProvider(context, _user?.companyId ?? ''));
    return isLoading
        ? const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: appBarWidget('Rebursement Request Form'),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dateTimePicker(
                          title: 'Reimburse Date',
                          hinttitle: 'Choose Duration',
                          controller: rebursementController,
                          context: context,
                          icons: Image.asset('assets/reimbursment/date.png')),
                    ),
                    reimbusmentProvider.when(
                      loading: () => const SizedBox(
                        height: 80,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (error, stackTrace) {
                        return Scaffold(
                          body: Center(
                            child: IconButton(
                                onPressed: () {
                                  ref.refresh(userDataProvider(context));
                                },
                                icon: const Icon(Icons.refresh)),
                          ),
                        );
                      },
                      data: (data) {
                        List<String> value = [];
                        Map<String, String> reimbusmentType = {};

                        for (var element in data) {
                          value.add(element.value ?? '');
                          reimbusmentType[element.value ?? ''] = element.key ??
                              ''; // Menyimpan key untuk setiap value
                        }
                        return dropdownIcon(
                            title: 'Rebursement Type',
                            listiem: value,
                            hinttitle: 'Choose type',
                            selectedValue: selectedValueType,
                            onchange: (newValue) {
                              setState(() {
                                reimbusmenttypeid = reimbusmentType[newValue!]!;
                              });
                            },
                            icons: Image.asset(
                                'assets/reimbursment/choicetype.png'));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Remaining balance: Rp. ${_user?.reimbursementLimit}' ??
                            '0',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Expenses',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showAddExpenseBottomSheet(context);
                            },
                            child: Text(
                              'Add Expense',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    expensesList.isEmpty
                        ? const Center(child: Text('No Data'))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: expensesList.length,
                            itemBuilder: (context, index) {
                              final expense = expensesList[index];
                              return Container(
                                height: 74,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: HexColor('#EAEAEA'))),
                                child: Center(
                                  child: ListTile(
                                    title: Text(
                                      expense.expensesId,
                                      style: GoogleFonts.inter(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      'Rp ${expense.value}',
                                      style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                                reimbursementExpenseNotifierProvider
                                                    .notifier)
                                            .removeExpense(index);
                                        selectExpense.removeAt(index);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                    const SizedBox(
                      height: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Upload File'),
                    ),
                    Wrap(
                      children: [
                        ...imageList.asMap().entries.map((entry) {
                          int index = entry.key; // Mendapatkan indeks
                          return GestureDetector(
                            onTap: () {
                              ref
                                  .read(reimbursementImageProvider.notifier)
                                  .removeImage(index);
                            },
                            child: Container(
                              height: 56,
                              width: 56,
                              margin: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                'assets/reimbursment/upload.png', // Menampilkan file gambar
                                height:
                                    50, // Atur tinggi gambar sesuai kebutuhan
                                width: 50, // Atur lebar gambar sesuai kebutuhan
                                fit: BoxFit
                                    .cover, // Mengatur cara gambar diubah ukurannya
                              ),
                            ),
                          );
                        }),
                        GestureDetector(
                          onTap: _pickFile,
                          child: Container(
                            height: 56,
                            width: 56,
                            margin: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: HexColor('#B3B3B3'))),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: HexColor('#B3B3B3'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Max 20 MB'),
                    ),

                    // Tampilkan gambar yang dipilih
                  ],
                ),
              ),
            ),
            bottomNavigationBar: bootomSubmit(
              'Submit Request',
              Image.asset('assets/submit.png'),
              () => submit(selectExpense),
            ),
          );
  }

  void _showAddExpenseBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final TextEditingController expenseAmountController =
            TextEditingController();

        return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Expense',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expense Type',
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
                          child: DropdownButtonFormField<DropdownModel>(
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 22.0),
                              child: Text(
                                'Choose expense',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: HexColor('#B3B3B3'),
                                ),
                              ),
                            ),
                            value: selectDropdown,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            items: listDropdown.map((item) {
                              return DropdownMenuItem<DropdownModel>(
                                value: item,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 3, left: 20.0),
                                  child: Text(item.value ?? ''),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectDropdown =
                                    value!; // Memperbarui selectDropdown
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  textFieldIcon(
                    hinttitle: 'Input Amount',
                    title: 'Amount',
                    icon: Text(
                      textAlign: TextAlign.center,
                      'Rp',
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    controller: expenseAmountController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final amount =
                          double.tryParse(expenseAmountController.text) ?? 0;

                      // Pastikan selectDropdown dan amount valid
                      if (selectDropdown.value != null &&
                          selectDropdown.key != null &&
                          amount > 0) {
                        final newExpense = ExpensesModel(
                          expensesId: selectDropdown.value!,
                          value: amount,
                        );
                        final nexIdType = ExpensesModel(
                          expensesId: selectDropdown.key!,
                          value: amount,
                        );

                        final notifier = ref.read(
                            reimbursementExpenseNotifierProvider.notifier);

                        // Cek apakah newExpense sudah ada di state
                        if (!notifier.state.any((e) =>
                            e.expensesId == newExpense.expensesId &&
                            e.value == newExpense.value)) {
                          notifier.addExpense(newExpense); // Tambah ke state

                          // Cek apakah nexIdType sudah ada di selectExpense
                          if (!selectExpense.any((e) =>
                              e.expensesId == nexIdType.expensesId &&
                              e.value == nexIdType.value)) {
                            selectExpense
                                .add(nexIdType); // Menambahkan ke selectExpense
                          } else {
                            // Jika nexIdType sudah ada, tampilkan pesan kesalahan
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Pengeluaran dengan ID ini sudah ada.'),
                              ),
                            );
                            return; // Keluar dari fungsi jika sudah ada
                          }

                          Navigator.pop(context); // Menutup bottom sheet
                        } else {
                          // Tampilkan pesan kesalahan jika newExpense sudah ada
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pengeluaran ini sudah ada.'),
                            ),
                          );
                        }
                      } else {
                        // Tampilkan pesan kesalahan jika salah satu kondisi tidak terpenuhi
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Silakan pilih jenis pengeluaran dan masukkan jumlah yang valid.'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor('#01A2E9'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
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
                  overflow: TextOverflow
                      .ellipsis, // Memotong teks jika terlalu panjang
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
      ),
    );
  }

  Widget textFieldIcon({
    required String title,
    required TextEditingController controller,
    required String hinttitle,
    required Widget icon,
  }) {
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
            child: Row(
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
                  child: Center(child: icon),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      keyboardType: TextInputType
                          .number, // Menetapkan keyboard untuk input angka
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter
                            .digitsOnly, // Memastikan hanya input digit yang diterima
                      ],
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hinttitle,
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: HexColor('#B3B3B3'),
                        ),
                        border: InputBorder.none,
                        // Menghilangkan border default
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void submit(expensesList) {
    setState(() {
      isLoading = true; // Set loading menjadi true saat submit
    });

    Map<String, dynamic> dataSubmit = {
      "date": rebursementController.text,
      "reimbursementTypeId": reimbusmenttypeid,
      "expenses": expensesList
      // "files": ["data:$mimeType;base64,$base64String"],
    };

    final reimbusmentSave =
        ref.read(reimbusmentSaveDataProvider(context).notifier);
    reimbusmentSave
        .saveData(context: context, data: dataSubmit)
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

  Future<void> _pickFile() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        selectedFile = result.files.single;

        if (selectedFile!.size <= 3 * 1024 * 1024) {
          final bytes = await File(selectedFile!.path!).readAsBytes();
          setState(() {
            base64String = base64Encode(bytes);
            ref
                .read(reimbursementImageProvider.notifier)
                .addImage(selectedFile!);
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
