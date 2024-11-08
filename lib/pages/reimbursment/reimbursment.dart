import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/models/dropdown_model.dart';
import 'package:hris/models/reimbusment_model.dart';
import 'package:hris/pages/leave/leave.dart';
import 'package:hris/riverpod/masterdropdown.dart';
import 'package:hris/riverpod/reimbusment.dart';
import 'package:hris/riverpod/user.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
    final userData = ref.watch(userDataProvider(context));
    final reimbusmentApproved = ref.watch(rembusmentApprovedProvider.notifier);
    final reimbusmentPending = ref.watch(reimbusmentPendingProvider.notifier);

    reimbusmentPending.setParameters(
      monthParam: DateTime.now().month,
      yearParam: DateTime.now().year,
      contextParam: context,
    );

    int selectedIndex = DateTime.now().month - 1;
    TextEditingController choiceMonthController = TextEditingController();
    TextEditingController choiceStatusMonthController = TextEditingController();
    String monthValue = '';
    String keyValue = '';

    TextEditingController choiceYearController = TextEditingController();
    TextEditingController choiceStatusYearController = TextEditingController();
    List<DropdownModel> months = ref.watch(dropdownMonthProvider);
    List<DropdownModelYears> years = ref.watch(dropdownYearsProvider);
    int selectedMonth = 0;

    int selectYears = DateTime.now().year;
    return userData.when(
      loading: () {
        return Scaffold(
          appBar: appBarWidgetWithTralling(
              'Reimbursement', Image.asset('assets/filter.png')),
          body: Center(
            child: IconButton(
                onPressed: () {
                  return ref.refresh(userDataProvider(context));
                },
                icon: const Icon(Icons.refresh)),
          ),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          appBar: appBarWidgetWithTralling(
              'Reimbursement', Image.asset('assets/filter.png')),
        );
      },
      data: (data) {
        return Scaffold(
            appBar: appBarWidgetWithTralling(
                'Reimbursement', Image.asset('assets/filter.png')),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        HexColor('#01A2E9'),
                        HexColor('#284894'),
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
                        data?.reimbursementLimit.toString() ?? '0',
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
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Request'),
                    Tab(text: 'Approved'),
                  ],
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  onTap: (value) {
                    if (value == 0) {
                      reimbusmentPending.setParameters(
                        monthParam: (choiceMonthController.text.isNotEmpty)
                            ? int.parse(choiceMonthController.text)
                            : DateTime.now().month,
                        yearParam: (choiceYearController.text.isNotEmpty)
                            ? int.parse(choiceYearController.text)
                            : DateTime.now().year,
                        contextParam: context,
                      );
                    } else {
                      reimbusmentApproved.setParameters(
                        monthParam:
                            (choiceStatusMonthController.text.isNotEmpty)
                                ? int.parse(choiceStatusMonthController.text)
                                : DateTime.now().month,
                        yearParam: (choiceStatusYearController.text.isNotEmpty)
                            ? int.parse(choiceStatusYearController.text)
                            : DateTime.now().year,
                        contextParam: context,
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
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
                                                                'Month',
                                                                style:
                                                                    TextStyle(
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
                                                                  itemExtent:
                                                                      50,
                                                                  onSelectedItemChanged:
                                                                      (index) {
                                                                    monthValue =
                                                                        months[index]
                                                                            .value!;
                                                                    keyValue =
                                                                        months[index]
                                                                            .key!;
                                                                    setState(
                                                                        () {
                                                                      selectedIndex =
                                                                          index;
                                                                    });
                                                                  },
                                                                  children: List
                                                                      .generate(
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
                                                                            ? Colors.white
                                                                            : Colors.transparent,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          // Garis bawah
                                                                          Opacity(
                                                                            opacity: isSelected
                                                                                ? 1.0
                                                                                : 0.5,
                                                                            child:
                                                                                Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(16),
                                                                                child: Text(
                                                                                  months[index].value!,
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
                                                                              color: Colors.black,
                                                                              height: 2,
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

                                                                  // Ambil nama bulan

                                                                  setState(() {
                                                                    choiceMonthController
                                                                            .text =
                                                                        monthValue;
                                                                  });
                                                                  selectedMonth =
                                                                      int.parse(
                                                                          keyValue);
                                                                  reimbusmentPending
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
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: HexColor(
                                                                        '#01A2E9'),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(8)),
                                                                  ),
                                                                  width: double
                                                                      .infinity,
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                  height: 48,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'View',
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
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
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 12,
                                                      left: 16,
                                                      right: 16,
                                                      bottom: 12),
                                              hintText: 'Month',
                                              suffixIcon: const Icon(
                                                  Icons.arrow_drop_down),
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
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                    builder:
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
                                                                'Choose Year',
                                                                style:
                                                                    TextStyle(
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
                                                                  itemExtent:
                                                                      50,
                                                                  onSelectedItemChanged:
                                                                      (index) {
                                                                    // Mengupdate selectedIndex dengan setState
                                                                    setState(
                                                                        () {
                                                                      selectedIndex =
                                                                          index;
                                                                    });
                                                                  },
                                                                  children: List
                                                                      .generate(
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
                                                                            ? Colors.white
                                                                            : Colors.transparent,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          years[index]
                                                                              .value
                                                                              .toString(),
                                                                          style:
                                                                              GoogleFonts.inter(
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
                                                                      years[selectedIndex]
                                                                          .key
                                                                          .toString();
                                                                  choiceYearController
                                                                          .text =
                                                                      selectedYear; // Set ke controller

                                                                  selectYears =
                                                                      int.parse(
                                                                          choiceYearController
                                                                              .text);
                                                                  reimbusmentPending
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
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: HexColor(
                                                                        '#01A2E9'),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(8)),
                                                                  ),
                                                                  width: double
                                                                      .infinity,
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                  height: 48,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Select',
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
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
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 12,
                                                      left: 16,
                                                      right: 16,
                                                      bottom: 12),
                                              hintText: 'Year',
                                              suffixIcon: const Icon(
                                                  Icons.arrow_drop_down),
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
                            Expanded(
                              child: PagedListView<int, ReimbursementModel>(
                                shrinkWrap: true,
                                pagingController:
                                    reimbusmentPending.pagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                    ReimbursementModel>(
                                  itemBuilder: (context, item, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: HexColor('#EAEAEA')),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  item.reimbursementType.name ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ),
                                              ),
                                              statusWidget(item.status)
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Paid Rp ${item.total}',
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            formatDate(item.date),
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  noItemsFoundIndicatorBuilder: (_) =>
                                      dataNotFound(
                                          'There is no reimbrusment request yet'),
                                  firstPageErrorIndicatorBuilder: (_) =>
                                      const Center(
                                    child: Text('Failed to load data'),
                                  ),
                                  newPageErrorIndicatorBuilder: (_) =>
                                      const Center(
                                    child: Text('Failed to load more data'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
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
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
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
                                                                'Month',
                                                                style:
                                                                    TextStyle(
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
                                                                  itemExtent:
                                                                      50,
                                                                  onSelectedItemChanged:
                                                                      (index) {
                                                                    monthValue =
                                                                        months[index]
                                                                            .value!;
                                                                    keyValue =
                                                                        months[index]
                                                                            .key!;
                                                                    setState(
                                                                        () {
                                                                      selectedIndex =
                                                                          index;
                                                                    });
                                                                  },
                                                                  children: List
                                                                      .generate(
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
                                                                            ? Colors.white
                                                                            : Colors.transparent,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          // Garis bawah
                                                                          Opacity(
                                                                            opacity: isSelected
                                                                                ? 1.0
                                                                                : 0.5,
                                                                            child:
                                                                                Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(16),
                                                                                child: Text(
                                                                                  months[index].value!,
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
                                                                              color: Colors.black,
                                                                              height: 2,
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

                                                                  // Ambil nama bulan

                                                                  setState(() {
                                                                    choiceMonthController
                                                                            .text =
                                                                        monthValue;
                                                                  });
                                                                  selectedMonth =
                                                                      int.parse(
                                                                          keyValue);
                                                                  reimbusmentApproved
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
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: HexColor(
                                                                        '#01A2E9'),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(8)),
                                                                  ),
                                                                  width: double
                                                                      .infinity,
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                  height: 48,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'View',
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
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
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 12,
                                                      left: 16,
                                                      right: 16,
                                                      bottom: 12),
                                              hintText: 'Month',
                                              suffixIcon: const Icon(
                                                  Icons.arrow_drop_down),
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
                                                builder:
                                                    (BuildContext context) {
                                                  return StatefulBuilder(
                                                    builder:
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
                                                                'Choose Year',
                                                                style:
                                                                    TextStyle(
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
                                                                  itemExtent:
                                                                      50,
                                                                  onSelectedItemChanged:
                                                                      (index) {
                                                                    // Mengupdate selectedIndex dengan setState
                                                                    setState(
                                                                        () {
                                                                      selectedIndex =
                                                                          index;
                                                                    });
                                                                  },
                                                                  children: List
                                                                      .generate(
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
                                                                            ? Colors.white
                                                                            : Colors.transparent,
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          years[index]
                                                                              .value
                                                                              .toString(),
                                                                          style:
                                                                              GoogleFonts.inter(
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
                                                                      years[selectedIndex]
                                                                          .key
                                                                          .toString();
                                                                  choiceYearController
                                                                          .text =
                                                                      selectedYear; // Set ke controller

                                                                  selectYears =
                                                                      int.parse(
                                                                          choiceYearController
                                                                              .text);
                                                                  reimbusmentApproved
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
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: HexColor(
                                                                        '#01A2E9'),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(8)),
                                                                  ),
                                                                  width: double
                                                                      .infinity,
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                  height: 48,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Select',
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w700,
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
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 12,
                                                      left: 16,
                                                      right: 16,
                                                      bottom: 12),
                                              hintText: 'Year',
                                              suffixIcon: const Icon(
                                                  Icons.arrow_drop_down),
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
                            Expanded(
                              child: PagedListView<int, ReimbursementModel>(
                                shrinkWrap: true,
                                pagingController:
                                    reimbusmentApproved.pagingController,
                                builderDelegate: PagedChildBuilderDelegate<
                                    ReimbursementModel>(
                                  itemBuilder: (context, item, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: HexColor('#EAEAEA')),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  item.reimbursementType.name ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.inter(
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                ),
                                              ),
                                              statusWidget(item.status)
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Paid Rp ${item.total}',
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            formatDate(item.date),
                                            style: GoogleFonts.inter(
                                                textStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  noItemsFoundIndicatorBuilder: (_) =>
                                      dataNotFound(
                                          'There is no reimbrusment request yet'),
                                  firstPageErrorIndicatorBuilder: (_) =>
                                      const Center(
                                    child: Text('Failed to load data'),
                                  ),
                                  newPageErrorIndicatorBuilder: (_) =>
                                      const Center(
                                    child: Text('Failed to load more data'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // tabbar approved
              ],
            ),
            bottomNavigationBar: bootomSubmit(
                'Reimbursement Request',
                const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                () => context.goNamed('requestreimbursment')));
      },
    );
  }
}
