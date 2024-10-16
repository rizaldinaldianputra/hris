import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';

class EducationAddPage extends StatefulWidget {
  const EducationAddPage({super.key});

  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EducationAddPage> {
  List<Map<String, String>> emergencyContacts = [
    {
      'name': 'Sutan Sahrir',
      'relation': 'Colleague',
      'phone': '089272612834',
      'address':
          'Jl. Rawabambu Jl. Raya Rw. Bambu No.18, RT.13/RW.6, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta'
    }
  ];

  void _addContact() {
    setState(() {
      // Menambahkan kontak darurat baru ke dalam daftar
      emergencyContacts.add({
        'name': 'New Contact',
        'relation': 'Friend',
        'phone': '08123456789',
        'address': 'New Address, New City, New State'
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Education Info'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'List Education',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
              itemCount: emergencyContacts.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.goNamed('educationdetail');
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor('#EAEAEA')),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Universitas Gadjah Mada',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'See Detail',
                                      style: GoogleFonts.inter(
                                        color: HexColor('#3699FF'),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: HexColor('#3699FF'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Master’s Degree, Digital Innovation',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              'IPK 3.8',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: HexColor('#878787')),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '2020-2022',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: HexColor('#878787')),
                                ),
                                SvgPicture.asset(
                                    'assets/account/education_icon.svg')
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                context.goNamed('educationedit');
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Add Education',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
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
