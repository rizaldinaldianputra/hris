import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hris/pages/home/account.dart';
import 'package:hris/pages/home/attedant_log.dart';
import 'package:hris/pages/home/dashboard.dart';

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
    const AttedantLogPage(),
    const Center(child: Text('', style: TextStyle(fontSize: 24))),
    const Center(child: Text('', style: TextStyle(fontSize: 24))),
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
              color:
                  selectedIndex == 0 ? Colors.blue : Colors.grey, // Ubah warna
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/attedant_bottom.svg',
              color:
                  selectedIndex == 1 ? Colors.blue : Colors.grey, // Ubah warna
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/request_bottom.svg',
              color:
                  selectedIndex == 2 ? Colors.blue : Colors.grey, // Ubah warna
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/inbox_bottom.svg',
              color:
                  selectedIndex == 3 ? Colors.blue : Colors.grey, // Ubah warna
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/account_bottom.svg',
              color:
                  selectedIndex == 4 ? Colors.blue : Colors.grey, // Ubah warna
            ),
            label: '',
          ),
        ],
        currentIndex: selectedIndex, // Menentukan tab yang aktif
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Menangani tap pada tab
        type: BottomNavigationBarType.fixed, // Menghindari animasi zoom
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // Setel ke true untuk menjaga state
}
