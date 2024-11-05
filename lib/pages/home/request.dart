import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/utility/globalwidget.dart';

class RequesPage extends ConsumerStatefulWidget {
  const RequesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RequesPageState();
}

class _RequesPageState extends ConsumerState<RequesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Request'),
    );
  }
}
