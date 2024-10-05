import 'package:flutter/material.dart';
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
        TabController(length: 3, vsync: this); // Perbaiki panjang tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Attendance Log'), // Perbaiki penamaan
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Logs'),
              Tab(text: 'Attendance'),
              Tab(text: 'Shift'),
            ],
          ),
          Expanded(
            // Tambahkan Expanded agar TabBarView mengambil ruang yang tersisa
            child: TabBarView(
              controller: _tabController,
              children: const [
                LogsPage(),
                Center(
                    child: Text('Attendance', style: TextStyle(fontSize: 24))),
                Center(child: Text('Shift', style: TextStyle(fontSize: 24))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
