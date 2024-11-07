import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/status_color.dart';
import 'package:hris/models/leave_model.dart';
import 'package:hris/riverpod/leave.dart';

import 'package:hris/utility/globalwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class LeavePage extends ConsumerStatefulWidget {
  const LeavePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeavePageState();
}

class _LeavePageState extends ConsumerState<LeavePage>
    with SingleTickerProviderStateMixin {
  int selectedMonth = 0;
  TabController? tabController;
  String? statusLeave;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final leaveApproved = ref.watch(leaveApprovedProvider.notifier);
    final leavePending = ref.watch(leavePendingProvider.notifier);

    int selectedIndex = DateTime.now().month - 1;
    TextEditingController choiceMonthController = TextEditingController();
    TextEditingController choiceStatusMonthController = TextEditingController();

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

    String monthvalue = 'Month';
    TextEditingController choiceYearController = TextEditingController();
    TextEditingController choiceStatusYearController = TextEditingController();

    int selectedMonth = 0;

    int selectYears = DateTime.now().year;
    leavePending.setParameters(
        monthParam: DateTime.now().month,
        yearParam: DateTime.now().year,
        contextParam: context,
        statusLeave: 'pending');
    return Scaffold(
        appBar: appBarWidgetWithTralling(
            'Leave Request', Image.asset('assets/filter.png')),
        body: Column(
          children: [
            const SizedBox(
              height: 17,
            ),
            TabBar(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              labelColor: HexColor('#01A2E9'),
              unselectedLabelColor: Colors.black,
              onTap: (value) {
                if (value == 0) {
                  leavePending.setParameters(
                      monthParam: (choiceMonthController.text.isNotEmpty)
                          ? int.parse(choiceMonthController.text)
                          : DateTime.now().month,
                      yearParam: (choiceYearController.text.isNotEmpty)
                          ? int.parse(choiceYearController.text)
                          : DateTime.now().year,
                      contextParam: context,
                      statusLeave: 'pending');
                } else {
                  leaveApproved.setParameters(
                      monthParam: (choiceStatusMonthController.text.isNotEmpty)
                          ? int.parse(choiceStatusMonthController.text)
                          : DateTime.now().month,
                      yearParam: (choiceStatusYearController.text.isNotEmpty)
                          ? int.parse(choiceStatusYearController.text)
                          : DateTime.now().year,
                      contextParam: context,
                      statusLeave: 'pending');
                }
              },
              indicatorColor: HexColor('#01A2E9'),
              tabs: const [
                SizedBox(
                  height: 48,
                  child: Tab(text: 'Request'),
                ),
                SizedBox(
                  height: 48,
                  child: Tab(text: 'Approved'),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabController,
                  children: [
                    // leave pending
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
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
                                              color: HexColor('#D9D9D9'),
                                              width: 1),
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
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return SizedBox(
                                                    height: 350,
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 8),
                                                          Container(
                                                            height: 6,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: HexColor(
                                                                  '#EAEBEB'),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          200)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 40),
                                                          const Text(
                                                            'Choose Month',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 196,
                                                            height: 170,
                                                            child:
                                                                ListWheelScrollView(
                                                              itemExtent: 50,
                                                              onSelectedItemChanged:
                                                                  (index) {
                                                                setState(() {
                                                                  selectedIndex =
                                                                      index;
                                                                });
                                                              },
                                                              children:
                                                                  List.generate(
                                                                      months
                                                                          .length,
                                                                      (index) {
                                                                bool
                                                                    isSelected =
                                                                    index ==
                                                                        selectedIndex;
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: isSelected
                                                                        ? Colors
                                                                            .white
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
                                                                        opacity: isSelected
                                                                            ? 1.0
                                                                            : 0.5,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(16),
                                                                            child:
                                                                                Text(
                                                                              months[index],
                                                                              style: GoogleFonts.inter(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: isSelected ? HexColor('#333333') : Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            120,
                                                                        child:
                                                                            Divider(
                                                                          color:
                                                                              Colors.black,
                                                                          height:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Ambil tanggal bulan sekarang
                                                              selectedMonth =
                                                                  selectedIndex +
                                                                      1; // +1 karena bulan dimulai dari 0
                                                              final int
                                                                  currentYear =
                                                                  DateTime.now()
                                                                      .year;
                                                              final DateTime
                                                                  selectedDate =
                                                                  DateTime(
                                                                      currentYear,
                                                                      selectedMonth,
                                                                      1);

                                                              String monthName =
                                                                  months[selectedDate
                                                                          .month -
                                                                      1];
                                                              // Ambil nama bulan

                                                              setState(() {
                                                                choiceMonthController
                                                                        .text =
                                                                    monthName;
                                                              });

                                                              leavePending
                                                                  .updateDate(
                                                                newYear:
                                                                    selectYears,
                                                                newMonth:
                                                                    selectedMonth,
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Tutup modal
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: HexColor(
                                                                    '#01A2E9'),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            8)),
                                                              ),
                                                              width: double
                                                                  .infinity,
                                                              height: 48,
                                                              child: Center(
                                                                child: Text(
                                                                  'View',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16,
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
                                              top: 12,
                                              left: 16,
                                              right: 16,
                                              bottom: 12),
                                          hintText: 'Month',
                                          suffixIcon:
                                              const Icon(Icons.arrow_drop_down),
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
                                              color: HexColor('#D9D9D9'),
                                              width: 1),
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
                                                return (DateTime.now().year -
                                                        index)
                                                    .toString(); // Daftar tahun
                                              });

                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return SizedBox(
                                                    height: 350,
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 8),
                                                          Container(
                                                            height: 6,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: HexColor(
                                                                  '#EAEBEB'),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          200)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 40),
                                                          const Text(
                                                            'Years',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 196,
                                                            height: 170,
                                                            child:
                                                                ListWheelScrollView(
                                                              itemExtent: 50,
                                                              onSelectedItemChanged:
                                                                  (index) {
                                                                // Mengupdate selectedIndex dengan setState
                                                                setState(() {
                                                                  selectedIndex =
                                                                      index;
                                                                });
                                                              },
                                                              children:
                                                                  List.generate(
                                                                      years
                                                                          .length,
                                                                      (index) {
                                                                bool
                                                                    isSelected =
                                                                    index ==
                                                                        selectedIndex;
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: isSelected
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .transparent,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      years[
                                                                          index],
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: isSelected
                                                                            ? HexColor('#333333')
                                                                            : Colors.grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Ambil tahun yang dipilih
                                                              String
                                                                  selectedYear =
                                                                  years[
                                                                      selectedIndex];
                                                              choiceYearController
                                                                      .text =
                                                                  selectedYear; // Set ke controller

                                                              selectYears =
                                                                  int.parse(
                                                                      choiceYearController
                                                                          .text);
                                                              leavePending
                                                                  .updateDate(
                                                                newYear:
                                                                    selectYears,
                                                                newMonth:
                                                                    selectedMonth,
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Tutup modal
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: HexColor(
                                                                    '#01A2E9'),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            8)),
                                                              ),
                                                              width: double
                                                                  .infinity,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(16),
                                                              height: 48,
                                                              child: Center(
                                                                child: Text(
                                                                  'Select',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16,
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
                                              top: 12,
                                              left: 16,
                                              right: 16,
                                              bottom: 12),
                                          hintText: 'Years',
                                          suffixIcon:
                                              const Icon(Icons.arrow_drop_down),
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
                        // List Leave
                        Expanded(
                          child: PagedListView<int, LeaveModel>(
                            shrinkWrap: true,
                            pagingController: leavePending.pagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<LeaveModel>(
                              itemBuilder: (context, item, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: HexColor('#EAEAEA')),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              item.leaveType!.name ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        formatDate(item.date!),
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      statusWidget(item.status ?? '')
                                    ],
                                  ),
                                );
                              },
                              noItemsFoundIndicatorBuilder: (_) =>
                                  dataNotFound('There is no leave request yet'),
                              firstPageErrorIndicatorBuilder: (_) =>
                                  const Center(
                                child: Text('Failed to load data'),
                              ),
                              newPageErrorIndicatorBuilder: (_) => const Center(
                                child: Center(
                                    child: Text('Failed to load more data')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // approved

                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
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
                                              color: HexColor('#D9D9D9'),
                                              width: 1),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: choiceStatusMonthController,
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return StatefulBuilder(builder:
                                                    (context, setState) {
                                                  return SizedBox(
                                                    height: 350,
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 8),
                                                          Container(
                                                            height: 6,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: HexColor(
                                                                  '#EAEBEB'),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          200)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 40),
                                                          const Text(
                                                            'Choose Month',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 196,
                                                            height: 170,
                                                            child:
                                                                ListWheelScrollView(
                                                              itemExtent: 50,
                                                              onSelectedItemChanged:
                                                                  (index) {
                                                                setState(() {
                                                                  selectedIndex =
                                                                      index;
                                                                });
                                                              },
                                                              children:
                                                                  List.generate(
                                                                      months
                                                                          .length,
                                                                      (index) {
                                                                bool
                                                                    isSelected =
                                                                    index ==
                                                                        selectedIndex;
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: isSelected
                                                                        ? Colors
                                                                            .white
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
                                                                        opacity: isSelected
                                                                            ? 1.0
                                                                            : 0.5,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(16),
                                                                            child:
                                                                                Text(
                                                                              months[index],
                                                                              style: GoogleFonts.inter(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: isSelected ? HexColor('#333333') : Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            120,
                                                                        child:
                                                                            Divider(
                                                                          color:
                                                                              Colors.black,
                                                                          height:
                                                                              2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Ambil tanggal bulan sekarang
                                                              selectedMonth =
                                                                  selectedIndex +
                                                                      1; // +1 karena bulan dimulai dari 0
                                                              final int
                                                                  currentYear =
                                                                  DateTime.now()
                                                                      .year;
                                                              final DateTime
                                                                  selectedDate =
                                                                  DateTime(
                                                                      currentYear,
                                                                      selectedMonth,
                                                                      1);

                                                              String monthName =
                                                                  months[selectedDate
                                                                          .month -
                                                                      1];
                                                              // Ambil nama bulan

                                                              setState(() {
                                                                choiceStatusMonthController
                                                                        .text =
                                                                    monthName;
                                                              });

                                                              leaveApproved
                                                                  .updateDate(
                                                                newYear:
                                                                    selectYears,
                                                                newMonth:
                                                                    selectedMonth,
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Tutup modal
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: HexColor(
                                                                    '#01A2E9'),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            8)),
                                                              ),
                                                              width: double
                                                                  .infinity,
                                                              height: 48,
                                                              child: Center(
                                                                child: Text(
                                                                  'View',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16,
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
                                              top: 12,
                                              left: 16,
                                              right: 16,
                                              bottom: 12),
                                          hintText: 'Month',
                                          suffixIcon:
                                              const Icon(Icons.arrow_drop_down),
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
                                              color: HexColor('#D9D9D9'),
                                              width: 1),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: choiceStatusYearController,
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
                                                return (DateTime.now().year -
                                                        index)
                                                    .toString(); // Daftar tahun
                                              });

                                              return StatefulBuilder(
                                                builder: (context, setState) {
                                                  return SizedBox(
                                                    height: 350,
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 8),
                                                          Container(
                                                            height: 6,
                                                            width: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: HexColor(
                                                                  '#EAEBEB'),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          200)),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 40),
                                                          const Text(
                                                            'Years',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 196,
                                                            height: 170,
                                                            child:
                                                                ListWheelScrollView(
                                                              itemExtent: 50,
                                                              onSelectedItemChanged:
                                                                  (index) {
                                                                // Mengupdate selectedIndex dengan setState
                                                                setState(() {
                                                                  selectedIndex =
                                                                      index;
                                                                });
                                                              },
                                                              children:
                                                                  List.generate(
                                                                      years
                                                                          .length,
                                                                      (index) {
                                                                bool
                                                                    isSelected =
                                                                    index ==
                                                                        selectedIndex;
                                                                return Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: isSelected
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .transparent,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      years[
                                                                          index],
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: isSelected
                                                                            ? HexColor('#333333')
                                                                            : Colors.grey,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // Ambil tahun yang dipilih
                                                              String
                                                                  selectedYear =
                                                                  years[
                                                                      selectedIndex];
                                                              choiceStatusYearController
                                                                      .text =
                                                                  selectedYear; // Set ke controller

                                                              selectYears =
                                                                  int.parse(
                                                                      choiceStatusYearController
                                                                          .text);
                                                              leaveApproved
                                                                  .updateDate(
                                                                newYear:
                                                                    selectYears,
                                                                newMonth:
                                                                    selectedMonth,
                                                              );
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // Tutup modal
                                                            },
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: HexColor(
                                                                    '#01A2E9'),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            8)),
                                                              ),
                                                              width: double
                                                                  .infinity,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(16),
                                                              height: 48,
                                                              child: Center(
                                                                child: Text(
                                                                  'Select',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16,
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
                                              top: 12,
                                              left: 16,
                                              right: 16,
                                              bottom: 12),
                                          hintText: 'Years',
                                          suffixIcon:
                                              const Icon(Icons.arrow_drop_down),
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
                          height: 8,
                        ),
                        Expanded(
                          child: PagedListView<int, LeaveModel>(
                            shrinkWrap: true,
                            pagingController: leaveApproved.pagingController,
                            builderDelegate:
                                PagedChildBuilderDelegate<LeaveModel>(
                              itemBuilder: (context, item, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: HexColor('#EAEAEA')),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              item.leaveType!.name ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.inter(
                                                  textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        formatDate(item.date!),
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      statusWidget(item.status ?? '')
                                    ],
                                  ),
                                );
                              },
                              noItemsFoundIndicatorBuilder: (_) =>
                                  dataNotFound('There is no leave request yet'),
                              firstPageErrorIndicatorBuilder: (_) =>
                                  const Center(
                                child: Text('Failed to load data'),
                              ),
                              newPageErrorIndicatorBuilder: (_) => const Center(
                                child: Text('Failed to load more data'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: bootomSubmit(
            'Leave Request',
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            () => context.goNamed('requestleave')));
  }
}

String formatDate(String date) {
  // Mengonversi string ke DateTime
  DateTime parsedDate = DateTime.parse(date);
  // Format ulang ke dd MMM yyyy
  String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
  return formattedDate;
}


  //  PagedListView<int, LeaveModel>(
  //           shrinkWrap: true,
  //           pagingController: ref.watch(
  //               leaveListProvider(context)), // Ensure proper provider access
  //           builderDelegate: PagedChildBuilderDelegate<LeaveModel>(
  //             itemBuilder: (context, item, index) {
  //               return GestureDetector(
  //                 onTap: () {},
  //               );
  //             },
  //             firstPageProgressIndicatorBuilder: (context) =>
  //                 const Center(child: CircularProgressIndicator()),
  //             newPageProgressIndicatorBuilder: (context) =>
  //                 const Center(child: CircularProgressIndicator()),
  //             noItemsFoundIndicatorBuilder: (context) => const Center(
  //                 child: Text(
  //               'No items found',
  //               style: TextStyle(color: Colors.white),
  //             )),
  //           ),
  //         ),