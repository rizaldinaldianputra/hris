import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';

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
              Container(
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
                          itemCardGrid('2', 'Absent'),
                          const SizedBox(
                            width: 4,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          itemCardGrid('0', 'No Clock-in'),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          itemCardGrid('2', 'Late Clock-in'),
                          const SizedBox(
                            width: 4,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          itemCardGrid('1', 'No Clock-out '),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          itemCardGrid('0', 'Early Clock-in'),
                          const SizedBox(
                            width: 4,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: Center(
                                  child: Text(
                                '',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12)))
                          ]),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                    ]),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.3, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: List.generate(20, (index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.3, color: Colors.grey),
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Mulai dari kiri
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // Pusatkan vertikal
                                    children: [
                                      Text(
                                        '${index + 1} Jun', // Menampilkan nomor item
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Text(
                                        'Work Shift', // Menampilkan filter bulan
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                // Bagian kanan: Menampilkan tanggal
                                Text(
                                  '08:35', // Tanggal
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        color: HexColor('B21616')),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  '17:32', // Tanggal
                                  style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
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
