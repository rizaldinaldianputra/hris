import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/status_color.dart';
import 'package:hris/utility/globalwidget.dart';

class ReimbursmentPage extends ConsumerStatefulWidget {
  const ReimbursmentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReimbursmentPageState();
}

class _ReimbursmentPageState extends ConsumerState<ReimbursmentPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Jumlah tab
  }

  @override
  void dispose() {
    _tabController!
        .dispose(); // Dispose controller untuk menghindari memory leak
    super.dispose();
  }

  TextEditingController dateTimeEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWidgetWithTralling(
            'Reimbursement', Image.asset('assets/filter.png')),
        body: Column(
          children: [
            Container(
              height: 105,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    HexColor('#01A2E9'),
                    Colors.lightBlue,
                    Colors.lightBlue,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Remaining Balance:',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Rp 8.888.000',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // TabBar di bawah balance
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Request'),
                Tab(text: 'Approved'),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  requestReimbursment(),
                  requestReimbursment(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: bootomSubmit(
            'Reimbursement Request',
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            () => context.goNamed('requestreimbursment')));
  }

  Widget requestReimbursment() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
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
                    dateTimeEditingController.text =
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
                    child: Image.asset('assets/reimbursment/date.png'),
                  ),
                  Text(
                    selectedDateTime != null
                        ? "${selectedDateTime!.day}/${selectedDateTime!.month}/${selectedDateTime!.year} ${selectedDateTime!.hour}:${selectedDateTime!.minute}"
                        : 'Choose Month',
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
                    Icons.keyboard_arrow_down,
                    color: HexColor('#757575'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20), // Tambahkan jarak antara tanggal dan list
          Expanded(
            // Tambahkan Expanded agar ListView.builder memiliki ruang untuk menampilkan itemnya
            child: ListView.builder(
              itemCount:
                  5, // Berikan itemCount agar ListView.builder dapat menampilkan beberapa item
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: HexColor('#EAEAEA')),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sick leave request',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                color: statusColor('Rejected'),
                                child: Text(
                                  'Rejected',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: statusColorText('Rejected'),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Paid Rp 56.000',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '08 Nov 2022',
                        style: GoogleFonts.inter(
                            color: HexColor('#757575'),
                            textStyle: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
