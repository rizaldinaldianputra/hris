import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({super.key});

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  CameraController? _cameraController;
  final bool _isFlashOn = false;
  XFile? imageData;

  @override
  void initState() {
    super.initState();
    _getLocation();
    _initializeCamera();
  }

  String locationMessage = "Location not available";

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Periksa apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationMessage = 'Layanan lokasi tidak diaktifkan.';
      });
      return;
    }

    // Periksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationMessage = 'Izin lokasi ditolak.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationMessage = 'Izin lokasi ditolak secara permanen.';
      });
      return;
    }

    // Mendapatkan posisi saat ini
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        locationMessage =
            "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    } catch (e) {
      setState(() {
        locationMessage = "Gagal mendapatkan lokasi: $e";
      });
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );
      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      setState(() {}); // Update UI setelah kamera siap
    } catch (e) {
      print('Error inisialisasi kamera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose(); // Dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            if (_cameraController != null &&
                _cameraController!.value.isInitialized)
              SizedBox.expand(
                // Membuat CameraPreview memenuhi layar
                child: CameraPreview(_cameraController!),
              )
            else
              const Center(child: CircularProgressIndicator()),
            Center(
              child: Image.asset(
                'assets/camera_frame.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: GestureDetector(
                    onTap: () async {
                      if (_cameraController != null &&
                          _cameraController!.value.isInitialized) {
                        try {
                          imageData = await _cameraController!.takePicture();
                          setState(() {});
                          if (imageData != null) {
                            _getLocation;
                            context.goNamed('camerapreview', extra: imageData);
                          }
                        } catch (e) {
                          print("Gagal mengambil gambar: $e");
                        }
                      }
                    },
                    child: SvgPicture.asset('assets/camera_button.svg')),
              ),
            ),
          ],
        ));
  }
}
