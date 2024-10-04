import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hris/pages/home/attedant.dart';

import 'package:hris/pages/home/dashboard.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0; // Menyimpan index tab yang dipilih
  final List<Widget> widgetOptions = <Widget>[
    const DashboardPage(),
    const AttedantPage(),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index; // Mengubah tab yang dipilih
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        type: BottomNavigationBarType
            .fixed, // Menetapkan tipe menjadi fixed untuk menghindari animasi zoom
      ),
    );
  }
}
