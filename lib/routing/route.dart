import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/pages/auth/login.dart';
import 'package:hris/pages/home/home.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: <RouteBase>[
  GoRoute(
    path: '/',
    name: 'login',
    builder: (BuildContext context, GoRouterState state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: '/home',
    name: 'home',
    builder: (BuildContext context, GoRouterState state) {
      return const HomePage();
    },
  ),
]);
