import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:hris/riverpod/user.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  late String formattedDate;
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  LatLng? currentLocation;

  XFile? xFile;

  late Timer _timer;
  bool isObSecure = false;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        formattedDate = _getFormattedDate();
      });
    });
  }

  String _getFormattedDate() {
    return DateFormat('dd MMMM yyyy HH:mm:ss').format(DateTime.now());
  }

  @override
  void initState() {
    super.initState();

    formattedDate = _getFormattedDate();
    _startTimer();
    _initializeCamera();
    _getCurrentLocation();
  }

  Future<LatLng> _getCurrentLocation() async {
    // Meminta izin lokasi
    await _requestLocationPermission();

    try {
      // Memeriksa izin lokasi
      if (await Permission.location.isGranted) {
        // Mendapatkan lokasi saat ini
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
        });
      } else if (await Permission.location.isDenied) {
        // Tampilkan pesan bahwa izin ditolak
        print(
            "Location permission denied. Please enable location permission in settings.");
      } else if (await Permission.location.isPermanentlyDenied) {
        // Arahkan pengguna ke pengaturan aplikasi
        print(
            "Location permission permanently denied. Please enable it in app settings.");
        openAppSettings();
      }
    } catch (e) {
      print("Error getting location: $e");
    }

    return currentLocation!;
  }

  Future<void> _requestLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      // Jika izin belum diberikan, minta izin
      await Permission.location.request();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _cameraController?.dispose();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras![1], ResolutionPreset.high);

    await _cameraController!.initialize();
    setState(() {});
  }

  final int maxDays = 25;

  final bool _isFlashOn = false;

  int getCurrentDay() {
    final now = DateTime.now();
    return now.day;
  }

  int getDaysUntil25() {
    final now = DateTime.now();
    final gajianDate = DateTime(now.year, now.month, 25);

    if (now.isBefore(gajianDate)) {
      return gajianDate.difference(now).inDays;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentDay = getCurrentDay();
    int daysUntil25 = getDaysUntil25();
    double progress = currentDay <= maxDays
        ? currentDay / maxDays
        : (2 * maxDays - currentDay) / maxDays;
    String formattedDate =
        DateFormat('dd MMMM yyyy HH:mm:ss').format(DateTime.now());
    String currentMonth = DateFormat('MMM').format(DateTime.now());
    final userData = ref.watch(userDataProvider(context));
    final attedandeStatus = ref.watch(attedanceStatusProvider(context));
    return userData.when(data: (data) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.32,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor('#01A2E9'), HexColor('#274896')])),
            child: Column(
              children: [
                const SizedBox(height: 35),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data!.image == null
                          ? const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/profile.png'),
                            )
                          : CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(data.image ?? ''),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'${data.firstName!} '} ${data.lastName!}',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                textStyle: const TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                            ),
                            Text(
                              data.position!.name ?? '',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                textStyle: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 36,
                        width: 36,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: SvgPicture.asset(
                            'assets/bell.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 18, right: 18),
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Don’t miss your attendance today!',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w300,
                          textStyle: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            formattedDate,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      attedandeStatus.when(
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stackTrace) => IconButton(
                          onPressed: () {
                            ref.refresh(attedanceStatusProvider(context));
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                        data: (data) {
                          final bool isClockedIn = data?.clockInTime != null;
                          final bool isClockedOut = data?.clockOutTime != null;

                          return Container(
                            margin: const EdgeInsets.all(20),
                            height: 40,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton.icon(
                                  onPressed: (isClockedIn ==
                                          false) // Aktifkan Clock In jika belum ada clockInTime
                                      ? () {
                                          ref
                                              .read(statusProvider.notifier)
                                              .state = 'clockin';
                                          context.goNamed('camerapage');
                                        }
                                      : null,
                                  icon: const Icon(Icons.login,
                                      color: Colors.black),
                                  label: Text(
                                    'Clock In',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: (isClockedIn == false)
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text('|', style: TextStyle(fontSize: 20)),
                                TextButton.icon(
                                  onPressed: (isClockedIn &&
                                          !isClockedOut) // Aktifkan Clock Out jika sudah ada clockInTime dan belum ada clockOutTime
                                      ? () {
                                          ref
                                              .read(statusProvider.notifier)
                                              .state = 'clockout';
                                          context.goNamed('camerapage');
                                        }
                                      : null,
                                  icon: const Icon(Icons.logout,
                                      color: Colors.black),
                                  label: Text(
                                    'Clock Out',
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w500,
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        color: (isClockedIn && !isClockedOut)
                                            ? Colors.black
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          children: [
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.only(
                    top: 20, right: 12, left: 12, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0.5, color: Colors.grey),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.goNamed('attedantlog');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HexColor('#E4FBF1')),
                                  child: SvgPicture.asset(
                                    'assets/Clipboard.svg',
                                    height: 20, // Ukuran ikon
                                    width: 20, // Ukuran ikon
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Attedance\n Log',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.goNamed('leave');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HexColor('#FFF0E7')),
                                  child: SvgPicture.asset(
                                    'assets/Briefcase.svg',
                                    height: 20, // Ukuran ikon
                                    width: 20, // Ukuran ikon
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Leave\nRequest',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.goNamed('overtime');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: HexColor('#FFF7E4')),
                                  child: SvgPicture.asset(
                                    'assets/Clock.svg',
                                    height: 20, // Ukuran ikon
                                    width: 20, // Ukuran ikon
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Overtime\nRequest',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.goNamed('reimbursment');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor('#F0F2FF'),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/Shopping.svg',
                                    height: 20, // Ukuran ikon
                                    width: 20, // Ukuran ikon
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Reimbursement\nRequest',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: HexColor('#FFF0F0'),
                                ),
                                child: SvgPicture.asset(
                                  'assets/Pie.svg',
                                  height: 20, // Ukuran ikon
                                  width: 20, // Ukuran ikon
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Earned Wage\nAccess',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.goNamed('payslip');
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: HexColor('#FFF2FE'),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/File.svg',
                                    height: 20, // Ukuran ikon
                                    width: 20, // Ukuran ikon
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Payslip',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            // Card EWA
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Gaji Anda',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              textStyle: const TextStyle(
                                  fontSize: 14, color: Colors.black),
                            )),
                      ),
                      IconButton(
                        icon: Icon(isObSecure
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            isObSecure = !isObSecure;
                          });
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      isObSecure ? 'Rp*********' : 'Rp.5.000.000',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd MMM').format(DateTime.now()),
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: HexColor('#333333'))),
                        ),
                        Text(
                          '$daysUntil25 hari hingga gajihan',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: HexColor('#757575'))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            '25 $currentMonth',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: HexColor('#333333'))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: HexColor('#EBF6FF'),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Ambil Dana untuk kebutuhan darurat',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: HexColor('#01A2E9'))),
                        ),
                        Icon(
                          Icons.arrow_forward_outlined,
                          size: 20,
                          color: HexColor('#01A2E9'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      );
    }, error: (error, stack) {
      return Scaffold(
          body: Center(
        child: IconButton(
          icon: const Icon(
            Icons.refresh,
            color: Colors.blue,
            size: 40,
          ), // Ikon refresh
          onPressed: () {
            // Panggil fungsi refresh di sini
            ref.refresh(userDataProvider(context));
          },
        ),
      ));
    }, loading: () {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    });
  }
}
