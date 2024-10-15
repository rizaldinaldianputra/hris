import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/pages/attedance_logs/camera_preview.dart';

class FamilyDetailPage extends StatelessWidget {
  const FamilyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk ditampilkan
    final Map<String, String> familyDetails = {
      'Name': 'Sutan Sahrir',
      'Family Relation': 'Uncle',
      'Marital Status': 'Married',
      'Gender': 'Male',
      'Birth Date': '1880-05-20',
      'Birth Place': 'Washington',
      'Address': 'Jl. Rawabambu Jl. Raya Rw. Bambu No.18, RT.13/RW.6',
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
                  context.goNamed('familyedit');
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
            // Iterasi untuk setiap item di dalam familyDetails
            for (var entry in familyDetails.entries)
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
                    )
                  ],
                ),
              ),
            const SizedBox(height: 16),

            // Bagian untuk gambar profil
            const Text(
              'Photos',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/profile.png'), // Ganti dengan path gambar Anda
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Tombol "Delete Family"
            GestureDetector(
              onTap: () {
                // Tambahkan logika untuk menghapus kontak keluarga
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Delete Family',
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
