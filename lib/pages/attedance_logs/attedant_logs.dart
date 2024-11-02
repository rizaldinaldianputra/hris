import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/global_function.dart';
import 'package:hris/models/attedance_model.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class AttedantLogsPage extends ConsumerStatefulWidget {
  const AttedantLogsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttedantLogsPageState();
}

class _AttedantLogsPageState extends ConsumerState<AttedantLogsPage> {
  final ScrollController _scrollController = ScrollController();

  int selectedIndex = DateTime.now().month - 1;
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String monthvalue = 'Choice Month';

  TextEditingController choiceMonthController = TextEditingController();
  TextEditingController choiceYearController = TextEditingController();

  int selectedMonth = 0;

  int selectYears = DateTime.now().year;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final attendanceLogProvider =
        ref.read(attendanceLogPaginationNotifierProvider.notifier);

    // Set parameters pertama kali
    attendanceLogProvider.setParameters(
      monthParam: 10,
      yearParam: 2024,
      contextParam: context,
    );
    attendanceLogProvider.pagingController;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor('#D9D9D9'), width: 1),
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
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: choiceMonthController,
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.white,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                          builder: (context, setState) {
                                        return SizedBox(
                                          height: 350,
                                          width: double.infinity,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 8),
                                                Container(
                                                  height: 6,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#EAEBEB'),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                200)),
                                                  ),
                                                ),
                                                const SizedBox(height: 40),
                                                const Text(
                                                  'Choose Month',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 196,
                                                  height: 170,
                                                  child: ListWheelScrollView(
                                                    itemExtent: 50,
                                                    onSelectedItemChanged:
                                                        (index) {
                                                      setState(() {
                                                        selectedIndex = index;
                                                      });
                                                    },
                                                    children: List.generate(
                                                        months.length, (index) {
                                                      bool isSelected = index ==
                                                          selectedIndex;
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isSelected
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            // Garis bawah
                                                            Opacity(
                                                              opacity:
                                                                  isSelected
                                                                      ? 1.0
                                                                      : 0.5,
                                                              child: Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                  child: Text(
                                                                    months[
                                                                        index],
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: isSelected
                                                                          ? HexColor(
                                                                              '#333333')
                                                                          : Colors
                                                                              .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 120,
                                                              child: Divider(
                                                                color: Colors
                                                                    .black,
                                                                height: 2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Ambil tanggal bulan sekarang
                                                    selectedMonth = selectedIndex +
                                                        1; // +1 karena bulan dimulai dari 0
                                                    final int currentYear =
                                                        DateTime.now().year;
                                                    final DateTime
                                                        selectedDate = DateTime(
                                                            currentYear,
                                                            selectedMonth,
                                                            1);

                                                    String monthName = months[
                                                        selectedDate.month - 1];
                                                    // Ambil nama bulan

                                                    setState(() {
                                                      choiceMonthController
                                                          .text = monthName;
                                                    });

                                                    attendanceLogProvider
                                                        .updateDate(
                                                      newYear: selectYears,
                                                      newMonth: selectedMonth,
                                                    );
                                                    Navigator.of(context)
                                                        .pop(); // Tutup modal
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor('#01A2E9'),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  8)),
                                                    ),
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            16),
                                                    height: 48,
                                                    child: Center(
                                                      child: Text(
                                                        'View',
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    });
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 12, left: 16, right: 16, bottom: 12),
                                hintText: 'Choice Month',
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                hintStyle: GoogleFonts.inter(
                                    color: HexColor('#B3B3B3')),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: HexColor('#D9D9D9'), width: 1),
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
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: choiceYearController,
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.white,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    int selectedIndex =
                                        0; // Default ke tahun pertama
                                    List<String> years =
                                        List.generate(100, (index) {
                                      return (DateTime.now().year - index)
                                          .toString(); // Daftar tahun
                                    });

                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return SizedBox(
                                          height: 350,
                                          width: double.infinity,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 8),
                                                Container(
                                                  height: 6,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#EAEBEB'),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                200)),
                                                  ),
                                                ),
                                                const SizedBox(height: 40),
                                                const Text(
                                                  'Choose Year',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 196,
                                                  height: 170,
                                                  child: ListWheelScrollView(
                                                    itemExtent: 50,
                                                    onSelectedItemChanged:
                                                        (index) {
                                                      // Mengupdate selectedIndex dengan setState
                                                      setState(() {
                                                        selectedIndex = index;
                                                      });
                                                    },
                                                    children: List.generate(
                                                        years.length, (index) {
                                                      bool isSelected = index ==
                                                          selectedIndex;
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: isSelected
                                                              ? Colors.white
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            years[index],
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: isSelected
                                                                  ? HexColor(
                                                                      '#333333')
                                                                  : Colors.grey,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                GestureDetector(
                                                  onTap: () {
                                                    // Ambil tahun yang dipilih
                                                    String selectedYear =
                                                        years[selectedIndex];
                                                    choiceYearController.text =
                                                        selectedYear; // Set ke controller

                                                    selectYears = int.parse(
                                                        choiceYearController
                                                            .text);
                                                    attendanceLogProvider
                                                        .updateDate(
                                                      newYear: selectYears,
                                                      newMonth: selectedMonth,
                                                    );
                                                    Navigator.of(context)
                                                        .pop(); // Tutup modal
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor('#01A2E9'),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  8)),
                                                    ),
                                                    width: double.infinity,
                                                    margin:
                                                        const EdgeInsets.all(
                                                            16),
                                                    height: 48,
                                                    child: Center(
                                                      child: Text(
                                                        'Select',
                                                        style:
                                                            GoogleFonts.inter(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    top: 12, left: 16, right: 16, bottom: 12),
                                hintText: 'Choice Year',
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                hintStyle: GoogleFonts.inter(
                                    color: HexColor('#B3B3B3')),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              PagedListView<int, AttendanceModel>(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                pagingController: attendanceLogProvider.pagingController,
                builderDelegate: PagedChildBuilderDelegate<AttendanceModel>(
                  itemBuilder: (context, item, index) {
                    String clockInString =
                        convertTimeOfDayToString(item.clockInTime);
                    String clockOutString =
                        convertTimeOfDayToString(item.clockOutTime);
                    String formattedDate = DateFormat('d MMM')
                        .format(item.date!); // Format menjadi '19 Jun'
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#EAEAEA')),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50, // Tinggi masing-masing item
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Bagian kiri: menampilkan judul item
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            formattedDate, // Mengambil tanggal dari model
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        'Work Shift', // Menampilkan filter bulan
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 40),
                                // Bagian kanan: Menampilkan waktu masuk dan keluar
                                Text(
                                  item.clockInTime != null
                                      ? clockInString.toString()
                                      : 'null', // Mengambil waktu check-in dari model
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        color: HexColor('B21616')),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  item.clockOutTime != null
                                      ? clockOutString.toString()
                                      : 'null', // Mengambil waktu check-out dari model
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(Icons.arrow_forward_ios, size: 14),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) => const Center(
                    child: Text('No attendance logs found'),
                  ),
                  firstPageErrorIndicatorBuilder: (_) => const Center(
                    child: Text('Failed to load data'),
                  ),
                  newPageErrorIndicatorBuilder: (_) => const Center(
                    child: Text('Failed to load more data'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemCardGrid(String count, String title) {
    return Column(children: [
      Container(
        height: 40,
        width: 40,
        decoration:
            BoxDecoration(color: HexColor('#F7F7F7'), shape: BoxShape.circle),
        child: Center(
            child: Text(
          count,
          style: GoogleFonts.inter(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        )),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(title,
          style: GoogleFonts.inter(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 12)))
    ]);
  }
}
