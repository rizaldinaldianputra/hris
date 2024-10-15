import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/routing/route.dart';
import 'package:hris/utility/globalwidget.dart';

class EmergencyAddContactPage extends StatefulWidget {
  const EmergencyAddContactPage({super.key});

  @override
  _EmergencyContactPageState createState() => _EmergencyContactPageState();
}

class _EmergencyContactPageState extends State<EmergencyAddContactPage> {
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
      appBar: appBarWidget('Emergency Contact'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'List Emergency Contact',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: emergencyContacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.goNamed('emergencydetail');
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sutan Sahir',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: HexColor('#3699FF'),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Sutan Sahir',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: HexColor('#878787')),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                '089272612834',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: HexColor('#878787')),
                              ),
                              Text(
                                'Jl. Rawabambu Jl. Raya Rw. Bambu No.18, RT.13/RW.6, Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12520',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: HexColor('#878787')),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Add Contact Emergency',
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
