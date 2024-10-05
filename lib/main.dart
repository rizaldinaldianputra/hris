import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/routing/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final routerConfig = router;

    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      routerDelegate: routerConfig.routerDelegate,
      routeInformationParser: routerConfig.routeInformationParser,
      routeInformationProvider: routerConfig.routeInformationProvider,
    );
  }
}
