import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/statemanagament/attedant.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';

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

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
      });

      print(currentLocation);
    } catch (e) {
      print("Error getting location: $e");
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
    _cameraController =
        CameraController(cameras![1], ResolutionPreset.ultraHigh);

    await _cameraController!.initialize();
    setState(() {});
  }

  final int maxDays = 25;

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

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [HexColor('#01A2E9'), HexColor('#274896')])),
          child: Column(
            children: [
              const SizedBox(height: 30),
              ListTile(
                leading: const CircleAvatar(),
                subtitle: Text(
                  'Supervisor',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    textStyle: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                title: Text(
                  'Jane Doe',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    textStyle:
                        const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                trailing: Container(
                  height: 46,
                  width: 46,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/notif.png'),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Don’t miss your attendance today!',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w300,
                        textStyle:
                            const TextStyle(fontSize: 12, color: Colors.white),
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
                    Container(
                      margin: const EdgeInsets.all(20),
                      height: 40,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              showBottomAttendant('Check In', context);
                            },
                            icon: const Icon(Icons.login, color: Colors.black),
                            label: Text(
                              'Clock In',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                textStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                          const Text('|', style: TextStyle(fontSize: 20)),
                          TextButton.icon(
                            onPressed: () {
                              showBottomAttendant(
                                'Check Out',
                                context,
                              );
                            },
                            icon: const Icon(Icons.logout, color: Colors.black),
                            label: Text(
                              'Clock Out',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                textStyle: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.35,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children: [
                Image.asset('assets/attedant.png'),
                GestureDetector(
                    onTap: () {
                      context.goNamed('leave');
                    },
                    child: Image.asset('assets/leave.png')),
                Image.asset('assets/overtime.png'),
                Image.asset('assets/reimbursment.png'),
                Image.asset('assets/earned.png'),
                Image.asset('assets/payslip.png'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Gaji Anda',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            textStyle: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          )),
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    Text(
                      '25 $currentMonth',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: HexColor('#333333'))),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                  margin: const EdgeInsets.only(left: 10, right: 19),
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
                                fontWeight: FontWeight.w700,
                                color: HexColor('#01A2E9'))),
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: HexColor('#01A2E9'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showBottomAttendant(String type, BuildContext context) {
    Uint8List? capturedImage;
    DateTime? timeCaputre;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setstate) {
          return FractionallySizedBox(
            heightFactor: 0.8,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        FlutterMap(
                          options: MapOptions(
                            initialZoom: 13,
                            initialCenter:
                                currentLocation ?? const LatLng(000000, 000000),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(markers: [
                              Marker(
                                  point: currentLocation ??
                                      const LatLng(2321, 221312),
                                  child: const Icon(
                                    Icons.pin_drop,
                                    size: 40,
                                    color: Colors.red,
                                  )),
                            ])
                          ],
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: _getCurrentLocation,
                            tooltip: 'Get Location',
                            child: const Icon(Icons.my_location),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                capturedImage != null
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return FractionallySizedBox(
                                  heightFactor: 1,
                                  widthFactor: 1,
                                  child: CameraPreview(
                                    _cameraController!,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (_cameraController != null &&
                                              _cameraController!
                                                  .value.isInitialized) {
                                            try {
                                              // Ambil gambar
                                              final XFile image =
                                                  await _cameraController!
                                                      .takePicture();
                                              final Uint8List imageData =
                                                  await image
                                                      .readAsBytes(); // Baca data gambar

                                              setstate(() {
                                                capturedImage = imageData;
                                                timeCaputre = DateTime.now();
                                              });

                                              ref
                                                  .watch(xFileNotifierProvider
                                                      .notifier)
                                                  .saveFile(
                                                      image); // Simpan file ke state
                                              Navigator.pop(
                                                  context); // Tutup modal
                                            } catch (e) {
                                              print(
                                                  "Gagal mengambil gambar: $e");
                                            }
                                          }
                                        },
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          margin: const EdgeInsets.all(20),
                                          child: const Icon(
                                            Icons.camera_alt_outlined,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Image.memory(
                            capturedImage!,
                          ),
                        ),
                      ) // Tampilkan gambar yang diambil
                    : GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return FractionallySizedBox(
                                heightFactor: 1,
                                widthFactor: 1,
                                child: CameraPreview(
                                  _cameraController!,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_cameraController != null &&
                                            _cameraController!
                                                .value.isInitialized) {
                                          try {
                                            // Ambil gambar
                                            final XFile image =
                                                await _cameraController!
                                                    .takePicture();
                                            final Uint8List imageData = await image
                                                .readAsBytes(); // Baca data gambar

                                            setstate(() {
                                              capturedImage = imageData;
                                              timeCaputre = DateTime.now();
// Simpan data gambar
                                            });

                                            ref
                                                .watch(xFileNotifierProvider
                                                    .notifier)
                                                .saveFile(
                                                    image); // Simpan file ke state
                                            Navigator.pop(
                                                context); // Tutup modal
                                          } catch (e) {
                                            print("Gagal mengambil gambar: $e");
                                          }
                                        }
                                      },
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        margin: const EdgeInsets.all(20),
                                        child: const Icon(
                                          Icons.camera_alt_outlined,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.all(20),
                            color: Colors.white,
                            height: 200,
                            width: double.infinity,
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                            )),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Jhon Doe',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: HexColor('#01A2E9'),
                          fontSize: 18,
                          fontWeight: FontWeight.w700)),
                ),
                const SizedBox(
                  height: 10,
                ), // Placeholder jika belum ada gambar
                timeCaputre != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd MMMM yyyy').format(timeCaputre!),
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat('HH:mm:ss').format(timeCaputre!),
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: HexColor('#01A2E9'),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ],
                      )
                    : const Text(''),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: HexColor('#01A2E9'),
                    ),
                    child: Center(
                      child: Text(
                        type,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        });
      },
    );
  }
}
