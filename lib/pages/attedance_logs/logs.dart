import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/models/attedance_list_logs_model.dart';
import 'package:hris/statemanagament/attedant.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:intl/intl.dart';

class LogsPage extends ConsumerStatefulWidget {
  const LogsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogsPageState();
}

class _LogsPageState extends ConsumerState<LogsPage> {
  final ScrollController _scrollController = ScrollController();

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  onTap: () {
                    showMonthWhell(context);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10), // Menambah ruang vertikal
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.3,
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                      size: 24,
                    ),
                    hintStyle: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: HexColor('#B3B3B3'),
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                    hintText: 'Choice Month',

                    prefixIcon: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey, width: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
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
              FutureBuilder<List<AttendanceListLogsModel>>(
                future: ref
                    .watch(AttedantListLogsProvider(context).notifier)
                    .listdataLogs(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Menampilkan indikator loading saat data sedang diambil
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Menampilkan pesan error jika terjadi kesalahan
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Menampilkan pesan jika tidak ada data
                    return const Center(child: Text('No data available'));
                  } else {
                    // Data tersedia, tampilkan daftar
                    final attendanceLogs = snapshot.data!;

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.3, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Column(
                        children: List.generate(attendanceLogs.length, (index) {
                          final log = attendanceLogs[index];
                          DateTime dateTime = DateTime.parse(log.date);
                          String formattedDate = DateFormat('d MMM')
                              .format(dateTime); // Format menjadi '19 Jun'

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.3, color: Colors.grey),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50, // Tinggi masing-masing item
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Bagian kiri: menampilkan judul item
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  fontSize: 14,
                                                  color: Colors.grey),
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
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.arrow_forward_ios,
                                          size: 14),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              )
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
