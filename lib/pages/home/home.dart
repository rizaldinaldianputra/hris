import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/pages/home/account.dart';
import 'package:hris/pages/attedance_logs/attedant.dart';
import 'package:hris/pages/home/attedant_view.dart';
import 'package:hris/pages/home/dashboard.dart';
import 'package:hris/pages/home/inbox.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  int selectedIndex = 0; // Menyimpan index tab yang dipilih
  late PageController
      _pageController; // Gunakan late untuk menjelaskan bahwa controller akan diinisialisasi di initState

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Inisialisasi controller di sini
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index; // Mengubah tab yang dipilih
      _pageController
          .jumpToPage(index); // Pindah ke halaman yang sesuai saat tab ditekan
    });
  }

  final List<Widget> widgetOptions = <Widget>[
    const DashboardPage(),
    const AttedantView(),
    const Center(child: Text('', style: TextStyle(fontSize: 24))),
    const InboxPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              selectedIndex =
                  index; // Mengubah tab yang dipilih saat halaman berubah
            });
          },
          children: widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/home_bottom.svg',
                color: selectedIndex == 0 ? HexColor('#378CCB') : Colors.grey,
                height: 24, // Tentukan ukuran ikon SVG
                width: 24,
              ),
              label: 'Home', // Anda bisa tambahkan label jika diperlukan
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/attedant_bottom.svg',
                color: selectedIndex == 1 ? HexColor('#378CCB') : Colors.grey,
              ),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/request_bottom.svg',
                color: selectedIndex == 2 ? HexColor('#378CCB') : Colors.grey,
              ),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/inbox_bottom.svg',
                color: selectedIndex == 3 ? HexColor('#378CCB') : Colors.grey,
              ),
              label: 'Inbox',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/account_bottom.svg',
                color: selectedIndex == 4 ? HexColor('#378CCB') : Colors.grey,
              ), // Gunakan ikon bawaan Flutter
              label: 'Account',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: HexColor('#378CCB'),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed, // Menjaga ikon di posisi tetap
        ));
  }

  @override
  bool get wantKeepAlive => true; // Setel ke true untuk menjaga state
}
