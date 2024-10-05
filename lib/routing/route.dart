import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/pages/auth/login.dart';
import 'package:hris/pages/home/home.dart';
import 'package:hris/pages/leave/leave.dart';
import 'package:hris/pages/leave/request_leave.dart';
import 'package:hris/pages/overtime/overtime.dart';
import 'package:hris/pages/overtime/request_overtime.dart';

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
    routes: <RouteBase>[
      GoRoute(
        path: '/leave',
        name: 'leave',
        builder: (BuildContext context, GoRouterState state) {
          return const LeavePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/requestleave',
            name: 'requestleave',
            builder: (BuildContext context, GoRouterState state) {
              return const RequestLeavePage();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/overtime',
        name: 'overtime',
        builder: (BuildContext context, GoRouterState state) {
          return const OvertimePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/requestovertime',
            name: 'requestovertime',
            builder: (BuildContext context, GoRouterState state) {
              return const RequestOvertime();
            },
          ),
        ],
      ),
    ],
  ),
]);
