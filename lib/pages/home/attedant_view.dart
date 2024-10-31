import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/helper/global_function.dart';
import 'package:hris/pages/attedance_logs/camera_preview.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:intl/intl.dart';

class AttedantView extends ConsumerStatefulWidget {
  const AttedantView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttedantViewState();
}

class _AttedantViewState extends ConsumerState<AttedantView> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy').format(DateTime.now());
    final attedandeStatus = ref.watch(attedanceStatusProvider(context));

    return attedandeStatus.when(
      loading: () {
        return Scaffold(
          appBar: appBarWidget('Attedance Detail'),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          appBar: appBarWidget('Attedance Detail'),
          body: Center(
            child: IconButton(
              onPressed: () {
                ref.refresh(attedanceStatusProvider(context));
              },
              icon: const Icon(Icons.refresh),
            ),
          ),
        );
      },
      data: (data) {
        String clockInString = convertTimeOfDayToString(data!.clockInTime);
        String clockOutString = convertTimeOfDayToString(data.clockOutTime);
        return Scaffold(
          appBar: appBarWidget('Attedance Detail'),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor('#EAEAEA'), // Warna border
                    ),
                    borderRadius:
                        BorderRadius.circular(8.0), // Radius sudut border
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Padding di dalam container
                    child: Column(
                      children: [
                        Text(
                          formattedDate,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Text('Clock In'),
                                const SizedBox(height: 8),
                                Text(
                                  clockInString ?? 'N/A', // Menangani null
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: HexColor('#B21616'),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('Clock Out'),
                                const SizedBox(height: 8),
                                Text(
                                  clockOutString ?? 'null', // Menangani null
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8.0),
                    child: Text(
                      'Photos Selfie',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: HexColor('#EAEAEA'), // Warna border
                    ),
                    borderRadius:
                        BorderRadius.circular(8.0), // Radius sudut border
                  ),
                  child: (data.clockInImage?.isEmpty ?? true) // Menangani null
                      ? Image.asset('assets/person.png')
                      : Image.network(data.clockInImage ?? ''),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
