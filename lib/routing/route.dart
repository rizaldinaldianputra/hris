import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/pages/account/personal_info.dart';
import 'package:hris/pages/attedance_logs/camera_attedant.dart';
import 'package:hris/pages/attedance_logs/camera_preview.dart';
import 'package:hris/pages/attedance_logs/dialog_succes.dart';
import 'package:hris/pages/auth/login.dart';
import 'package:hris/pages/home/attedant_log.dart';
import 'package:hris/pages/home/home.dart';
import 'package:hris/pages/leave/leave.dart';
import 'package:hris/pages/leave/request_leave.dart';
import 'package:hris/pages/overtime/overtime.dart';
import 'package:hris/pages/overtime/request_overtime.dart';
import 'package:hris/pages/payslip/detail_payslip.dart';
import 'package:hris/pages/payslip/payslip.dart';
import 'package:hris/pages/reimbursment/reimbursment.dart';
import 'package:hris/pages/reimbursment/reimbursment_request.dart';

final GoRouter router = GoRouter(initialLocation: '/', routes: <RouteBase>[
  GoRoute(
    path: '/',
    name: 'login',
    builder: (BuildContext context, GoRouterState state) {
      return const LoginPage();
    },
  ),
  GoRoute(
    path: '/dialogsucces',
    name: 'dialogsucces',
    builder: (BuildContext context, GoRouterState state) {
      return const DialogSuccesPage();
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
        path: '/personalinfo',
        name: 'personalinfo',
        builder: (BuildContext context, GoRouterState state) {
          return const PersonalInfoPage();
        },
      ),
      GoRoute(
        path: '/camerapage',
        name: 'camerapage',
        builder: (BuildContext context, GoRouterState state) {
          return const CameraPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/camerapreview',
            name: 'camerapreview',
            builder: (BuildContext context, GoRouterState state) {
              final imageBytes = state.extra as XFile?;

              return CamerPreviewPage(imageByte: imageBytes);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/attedantlog',
        name: 'attedantlog',
        builder: (BuildContext context, GoRouterState state) {
          return const AttedantLogPage();
        },
      ),
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
      GoRoute(
        path: '/reimbursment',
        name: 'reimbursment',
        builder: (BuildContext context, GoRouterState state) {
          return const ReimbursmentPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/requestreimbursment',
            name: 'requestreimbursment',
            builder: (BuildContext context, GoRouterState state) {
              return const RequestRebursement();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/payslip',
        name: 'payslip',
        builder: (BuildContext context, GoRouterState state) {
          return const PaySlipPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/paydetail',
            name: 'paydetail',
            builder: (BuildContext context, GoRouterState state) {
              return const PaySlipDetailPage();
            },
          ),
        ],
      ),
    ],
  ),
]);
