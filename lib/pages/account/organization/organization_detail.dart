import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class OrgnaizationDetailPage extends StatelessWidget {
  const OrgnaizationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk ditampilkan
    final Map<String, String> OrgnaizationDetails = {
      'Company Name': 'Universitas Gadjah Mada',
      'Location': 'Master’s Degree',
      'Line of Business': 'Digital Innovation',
      'Position': '2020-05-20',
      'Job Description': '-',
      'Achievement': '-',
      'Start Period': '2020-05-20',
      'End Period': '2022-05-20',
      'Initial Currency': '-',
      'Last Currency': '-',
      'Last Period': '-',
      'Reason Leaving': '-',
      'Reference Phone': '-',
      'Reference Position': '-',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Experience',
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF01A2E9),
        iconTheme: const IconThemeData(
          color: Colors.white, // Ubah warna ikon back
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () {
                  context.goNamed('organizationedit');
                },
                child: SvgPicture.asset('assets/account/edit.svg')),
          ),
        ],
        toolbarHeight: 56,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Iterasi untuk setiap item di dalam OrgnaizationDetails
              for (var entry in OrgnaizationDetails.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0), // Jarak lebih kecil
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: GoogleFonts.inter(
                          fontSize: 12, // Font lebih kecil
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 2), // Jarak lebih kecil
                      Text(
                        entry.value,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 14, // Font lebih kecil
                          fontWeight: FontWeight.w600,
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
                  // Tambahkan logika untuk menghapus kontak keluarga
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/delete.svg'),
                    const SizedBox(width: 8),
                    const Text(
                      'Delete Experience',
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
      ),
    );
  }
}
