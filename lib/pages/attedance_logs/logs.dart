import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/models/attedance_list_logs_model.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class LogsPage extends ConsumerStatefulWidget {
  const LogsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogsPageState();
}

class _LogsPageState extends ConsumerState<LogsPage> {
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
      monthParam: DateTime.now().month,
      yearParam: DateTime.now().year,
      contextParam: context,
    );
    attendanceLogProvider.pagingController;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              FutureBuilder(
                future: ref
                    .watch(attedantSumamryProvider(context).notifier)
                    .dataSummary(context),
                builder: (context, snapshot) {
                  // Menangani kondisi loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child:
                          CircularProgressIndicator(), // Menampilkan indikator loading
                    );
                  }

                  // Menangani kondisi error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}', // Menampilkan pesan error
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Menangani kondisi data null
                  if (snapshot.data == null) {
                    return const Center(
                      child: Text(
                        'No data available', // Pesan ketika data null
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  // Jika data ada, tampilkan konten
                  return Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, right: 12, left: 12),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemCardGrid(
                                snapshot.data!.absent.toString(), 'Absent'),
                            const SizedBox(width: 4),
                            const SizedBox(height: 20),
                            itemCardGrid(snapshot.data!.noClockin.toString(),
                                'No Clock-in'),
                            const SizedBox(width: 4),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemCardGrid(snapshot.data!.lateClockin.toString(),
                                'Late Clock-in'),
                            const SizedBox(width: 4),
                            const SizedBox(height: 20),
                            itemCardGrid(snapshot.data!.noClockout.toString(),
                                'No Clock-out'),
                            const SizedBox(width: 4),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            itemCardGrid(snapshot.data!.earlyClockin.toString(),
                                'Early Clock-in'),
                            const SizedBox(width: 4),
                            const SizedBox(height: 20),
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '',
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '',
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              PagedListView<int, AttendanceListLogsModel>(
                shrinkWrap: true,
                pagingController: attendanceLogProvider.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<AttendanceListLogsModel>(
                  itemBuilder: (context, item, index) {
                    final log = item;
                    DateTime dateTime = DateTime.parse(log.date);
                    String formattedDate = DateFormat('d MMM')
                        .format(dateTime); // Format menjadi '19 Jun'
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
                                  log.clockinTime
                                      .toString(), // Mengambil waktu check-in dari model
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        color: HexColor('B21616')),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  log.clockoutTime
                                      .toString(), // Mengambil waktu check-out dari model
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
                    child: Center(child: Text('No attendance logs found')),
                  ),
                  firstPageErrorIndicatorBuilder: (_) => const Center(
                    child: Center(child: Text('Failed to load data')),
                  ),
                  newPageErrorIndicatorBuilder: (_) => const Center(
                    child: Center(child: Text('Failed to load more data')),
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
