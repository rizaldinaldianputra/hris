import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/pages/attedance_logs/attedant_logs.dart';
import 'package:hris/pages/attedance_logs/logs.dart';
import 'package:hris/utility/globalwidget.dart';

class AttedantLogPage extends StatefulWidget {
  const AttedantLogPage({super.key});

  @override
  _AttendantLogPageState createState() => _AttendantLogPageState();
}

class _AttendantLogPageState extends State<AttedantLogPage>
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
      appBar: appBarWidgetWithTralling('Attendance Log',
          Image.asset('assets/filter.png')), // Perbaiki penamaan
      body: Column(
        children: [
          SizedBox(
            height: 57, // Atur tinggi menjadi 57
            child: TabBar(
              controller: _tabController,
              indicatorColor: HexColor('#01A2E9'),
              labelColor: HexColor('#01A2E9'),
              tabs: const [
                Tab(text: 'Logs'),
                Tab(text: 'Attendance'),
              ],
            ),
          ),
          Expanded(
            // Tambahkan Expanded agar TabBarView mengambil ruang yang tersisa
            child: TabBarView(
              controller: _tabController,
              children: const [LogsPage(), AttedantLogsPage()],
            ),
          ),
        ],
      ),
    );
  }
}
