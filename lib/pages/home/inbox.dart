import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Perbaiki panjang tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
        title: Text(
          'Inbox',
          style: GoogleFonts.inter(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          TabBar(
            physics: const NeverScrollableScrollPhysics(),
            dividerColor: Colors.transparent,
            controller: _tabController,
            onTap: (value) {
              setState(() {});
            },
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(200), // Atur radius indikator
            ),
            tabs: List<Widget>.generate(2, (index) {
              // Menentukan apakah tab terpilih
              bool isSelected = _tabController.index == index;

              return Container(
                height: 37,
                width: 171,
                decoration: BoxDecoration(
                  color: isSelected
                      ? HexColor('#01A2E9')
                      : Colors.white, // Warna latar belakang
                  borderRadius: const BorderRadius.all(Radius.circular(200)),
                ),
                child: Center(
                  child: Text(
                    index == 0
                        ? 'Shift'
                        : 'Need Approval', // Mengubah teks untuk setiap tab
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.black, // Warna teks
                    ),
                  ),
                ),
              );
            }),
          ),
          Expanded(
            // Tambahkan Expanded agar TabBarView mengambil ruang yang tersisa
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset('assets/open.svg'),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    'Rp 3.200.000',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    'Medical Reimbursement',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        color: HexColor('#757575'),
                                        fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Text(
                                    'Approved by Biko Maryono',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        color: HexColor('#757575'),
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.navigate_next),
                          ],
                        ),
                      );
                    }),
                const Center(
                    child:
                        Text('Need Approval', style: TextStyle(fontSize: 24))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
