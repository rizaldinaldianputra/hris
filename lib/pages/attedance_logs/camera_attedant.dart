import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:image/image.dart' as img;

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
        ref.read(latProvider.notifier).state = position.latitude.toString();
        ref.read(longProvider.notifier).state = position.longitude.toString();
      });

      print(locationMessage);
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
                        final imageData = await _captureAndCropImage();
                        if (imageData != null) {
                          // Navigasi ke halaman pratinjau dengan data gambar yang sudah dipotong
                          context.goNamed('camerapreview', extra: imageData);
                        }
                      }
                    },
                    child: SvgPicture.asset('assets/camera_button.svg')),
              ),
            ),
          ],
        ));
  }

  Future<XFile?> _captureAndCropImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return null;

    try {
      final imageFile = await _cameraController!.takePicture();
      final imageBytes = await imageFile.readAsBytes();
      final img.Image originalImage =
          img.decodeImage(Uint8List.fromList(imageBytes))!;

      // Menghitung ukuran crop
      final cropSize = (originalImage.width < originalImage.height)
          ? originalImage.width
          : originalImage.height;
      final offsetX = (originalImage.width - cropSize) ~/ 2;
      final offsetY = (originalImage.height - cropSize) ~/ 2;

      // Memotong gambar
      final img.Image croppedImage = img.copyCrop(
        originalImage,
        x: offsetX,
        y: offsetY,
        width: cropSize,
        height: cropSize,
      );

      // Mengonversi cropped image menjadi bytes
      final croppedImageBytes = img.encodeJpg(croppedImage);

      // Mengembalikan gambar cropped sebagai XFile
      final tempFile = File('${Directory.systemTemp.path}/cropped_image.jpg');
      await tempFile.writeAsBytes(croppedImageBytes);
      return XFile(tempFile.path);
    } catch (e) {
      print("Error capturing and cropping image: $e");
      return null;
    }
  }
}
