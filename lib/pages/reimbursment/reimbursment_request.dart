import 'dart:io'; // Tambahkan ini untuk menggunakan File
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/models/reimbursement%20_expense_model.dart';
import 'package:hris/statemanagament/reimbusment.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestRebursement extends ConsumerStatefulWidget {
  const RequestRebursement({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestRebursementState();
}

class _RequestRebursementState extends ConsumerState<RequestRebursement> {
  String? selectedValue;
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
  ];
  PlatformFile? selectedFile; // Mengubah menjadi PlatformFile

  TextEditingController rebursementController = TextEditingController();

  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();
  DateTime? selectedDateTime;

  @override
  Widget build(BuildContext context) {
    final expenses = ref.watch(reimbursementExpenseNotifierProvider);
    final imageList = ref.watch(reimbursementImageProvider);

    return Scaffold(
      appBar: appBarWidget('Rebursement Request Form'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dateTimePicker(
                  'Reimburse Date',
                  'Choose Duration',
                  rebursementController,
                  Image.asset('assets/reimbursment/date.png')),
              dropdownIcon(
                  title: 'Rebursement Type',
                  listiem: items,
                  hinttitle: 'Choose type',
                  selectedValue: selectedValue,
                  icons: Image.asset('assets/reimbursment/choicetype.png')),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Remaining balance: Rp 8.888.000',
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
              expenses.isEmpty
                  ? const Center(child: Text('No Data'))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];
                        return Container(
                          height: 74,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: HexColor('#EAEAEA'))),
                          child: Center(
                            child: ListTile(
                              title: Text(
                                expense.name!,
                                style: GoogleFonts.inter(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                'Rp ${expense.value!}',
                                style: GoogleFonts.inter(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  ref
                                      .read(reimbursementExpenseNotifierProvider
                                          .notifier)
                                      .removeExpense(index);
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
                          height: 50, // Atur tinggi gambar sesuai kebutuhan
                          width: 50, // Atur lebar gambar sesuai kebutuhan
                          fit: BoxFit
                              .cover, // Mengatur cara gambar diubah ukurannya
                        ),
                      ),
                    );
                  }),
                  GestureDetector(
                    onTap: () async {
                      var status = await Permission.storage.request();

                      // Cek status izin
                      if (status.isGranted) {
                        // Jika izin diberikan, pilih file
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          setState(() {
                            selectedFile =
                                result.files.single; // Ambil file yang dipilih
                          });
                          ref
                              .read(reimbursementImageProvider.notifier)
                              .addImage(selectedFile!);
                        }
                      } else if (status.isDenied) {
                        // Jika izin ditolak
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Storage permission denied')),
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
                    },
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
        () => context.goNamed('home'),
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
        return Padding(
          padding: MediaQuery.of(context)
              .viewInsets, // Mengatur agar bottom sheet tidak tertutup oleh keyboard
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
                        child: DropdownButtonFormField<String>(
                          hint: Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: Text(
                              'Choose expense',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: HexColor('#B3B3B3')),
                            ),
                          ),
                          value: selectedValue,
                          decoration: const InputDecoration(
                            border: InputBorder
                                .none, // Menghilangkan border default
                          ),
                          items: items.map((item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 3, left: 20.0),
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
                ),
                textFieldIcon(
                    hinttitle: 'Input Ammount',
                    title: 'Ammount',
                    icon: Text(
                      textAlign: TextAlign.center,
                      'Rp',
                      style: GoogleFonts.inter(fontSize: 14),
                    ),
                    controller: _expenseAmountController),
                ElevatedButton(
                  onPressed: () {
                    String expenseAmount = _expenseAmountController.text;
                    final newExpense = ReimbursementExpenseModel(
                      id: '2',
                      companyId: 'company_1',
                      employeeId: 'employee_1',
                      reimbursementRequestId: 'request_1',
                      reimbursementExpenseId: 'expense_2',
                      name: selectedValue,
                      value: double.parse(expenseAmount),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    ref
                        .read(reimbursementExpenseNotifierProvider.notifier)
                        .addExpense(newExpense);

                    // Tutup bottom sheet setelah submit
                    Navigator.pop(context);
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
          ),
        );
      },
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
                    controller.text =
                        newDateTime.toString(); // Simpan ke controller
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
}
