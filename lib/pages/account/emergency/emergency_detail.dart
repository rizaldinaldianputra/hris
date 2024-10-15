import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/pages/attedance_logs/camera_preview.dart';
import 'package:hris/routing/route.dart';
import 'package:hris/utility/globalwidget.dart';

class EmergencyContactDetailPage extends StatelessWidget {
  const EmergencyContactDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk ditampilkan
    final Map<String, String> contactDetails = {
      'Name': 'Sutan Sahrir',
      'Relation': 'Colleague',
      'Phone': '089272612834',
      'Address': 'Jl. Rawabambu Jl. Raya Rw. Bambu No.18, RT.13/RW.6',
      'Sub District': 'Maury Island',
      'District': 'Vashon Island',
      'City': 'Seattle',
      'Province': 'Washington',
      'Country': 'United States',
      'Postal Code': '234',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Contact',
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: HexColor('#01A2E9'),
        iconTheme: const IconThemeData(
          color: Colors.white, // Ubah warna ikon back
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
                  context.goNamed('emergencyedit');
                },
                child: SvgPicture.asset('assets/account/edit.svg')),
          ),
        ],
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Iterasi untuk setiap item di dalam contactDetails
            for (var entry in contactDetails.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.value,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                // Tambahkan logika untuk menghapus kontak
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Delete Contact',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
