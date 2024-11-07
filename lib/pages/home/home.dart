import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/pages/home/account.dart';
import 'package:hris/pages/attedance_logs/attedant.dart';
import 'package:hris/pages/home/attedant_view.dart';
import 'package:hris/pages/home/dashboard.dart';
import 'package:hris/pages/home/inbox.dart';
import 'package:hris/pages/home/request.dart';
import 'package:hris/riverpod/masterdropdown.dart';
import 'package:hris/riverpod/session.dart';
import 'package:hris/riverpod/user.dart';
import 'package:hris/service/dropdown_services.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = ref.read(pageControllerProvider);

    loadMonth().then((dropdownList) {
      // Jika ada data di SharedPreferences, simpan ke Riverpod
      ref.read(dropdownMonthProvider.notifier).setDropdownList(dropdownList);
    }).catchError((e) {
      print('Error loading SharedPreferences: $e');
    });
    loadYears().then((dropdownList) {
      // Jika ada data di SharedPreferences, simpan ke Riverpod
      ref.read(dropdownYearsProvider.notifier).setDropdownList(dropdownList);
    }).catchError((e) {
      print('Error loading SharedPreferences: $e');
    });

    // Mendapatkan data dari API dan menyimpannya
    DropdownServices(context).dropdownMonth(ref);
    DropdownServices(context).dropdownYears(ref);
  }

  void _onItemTapped(int index) {
    ref.read(selectedIndexProvider.notifier).state = index;
    _pageController.jumpToPage(index);
  }

  final List<Widget> widgetOptions = <Widget>[
    const DashboardPage(),
    const AttedantView(),
    const RequesPage(),
    const InboxPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          ref.read(selectedIndexProvider.notifier).state = index;
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
              height: 24,
              width: 24,
            ),
            label: 'Home',
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
            ),
            label: 'Account',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: HexColor('#378CCB'),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
