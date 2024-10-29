import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/riverpod/attedant.dart';
import 'package:hris/riverpod/user.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/utility/notifikasiwidget.dart';
import 'package:intl/intl.dart';

import '../../helper/global_function.dart';

class CamerPreviewPage extends ConsumerStatefulWidget {
  final XFile? imageByte;
  const CamerPreviewPage({super.key, required this.imageByte});

  @override
  ConsumerState<CamerPreviewPage> createState() => _CamerPreviewPageState();
}

class _CamerPreviewPageState extends ConsumerState<CamerPreviewPage> {
  Uint8List? fileImage;
  Notifikasi? notifikasi;

  String? base64String; // Untuk menyimpan hasil konversi Base64
  @override
  void initState() {
    super.initState();
    notifikasi = Notifikasi(context);
    if (widget.imageByte != null) {
      _loadImage();
    }
  }

  Future<void> _loadImage() async {
    try {
      fileImage = await widget.imageByte!.readAsBytes();
      setState(() {});
    } catch (e) {
      print("Error loading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataUser = ref.watch(attedanceStatusProvider(context));
    return dataUser.when(
      loading: () {
        return Scaffold(
          appBar: appBarWidget('Attendance Log'),
          body: const Center(child: CircularProgressIndicator()),
        );
      },
      error: (error, stackTrace) {
        return Scaffold(
          appBar: appBarWidget('Attendance Log'),
          body: Center(
            child: IconButton(
                onPressed: () {
                  ref.refresh(attedanceStatusProvider(context));
                },
                icon: const Icon(Icons.refresh)),
          ),
        );
      },
      data: (data) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd MMM yyyy').format(now);
        String startTime = data!.employeeShift?.startTime ?? '';
        String endTime = data.employeeShift?.endTime ?? '';
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: appBarWidget('Attendance Log'),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: HexColor('#01A2E9'),
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.employeeShift?.name ?? '',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text('$formattedDate ($startTime - $endTime)'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: ClipRRect(
                        child: fileImage != null
                            ? Image.memory(
                                fileImage!,
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height * 1,
                                width: double.infinity,
                              )
                            : const Center(
                                child: Text('No image available'),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              // Floating Submit and Location button on top of image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset(
                            'assets/location.png',
                            height: 18,
                            width: 18,
                            color: HexColor('#B3B3B3'),
                          ),
                        ),
                        title: Text(
                          'View location',
                          style: TextStyle(color: HexColor('#B3B3B3')),
                        ),
                        trailing: const Icon(Icons.navigate_next_outlined),
                      ),
                      GestureDetector(
                        onTap: () {
                          submitAttedant();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          height: 50,
                          decoration: BoxDecoration(
                            color: HexColor('#01A2E9'),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8)),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> submitAttedant() async {
    Future<Map<String, dynamic>> checkIn() async {
      DateTime now = DateTime.now();
      final base64String = await convertXFileToBase64(widget.imageByte!);
      String formattedTime = DateFormat('HH:mm:ss').format(now);
      if (base64String != null && widget.imageByte != null) {
        final mimeType = getMimeType(widget.imageByte!.path);
        return {
          "clockinTime": formattedTime,
          "clockinLat": ref.watch(latProvider),
          "clockinLong": ref.watch(longProvider),
          "clockinImage": "data:$mimeType;base64,$base64String",
        };
      }
      return {}; // Kembalikan map kosong jika tidak ada file yang diupload
    }

    Future<Map<String, dynamic>> checkOut() async {
      DateTime now = DateTime.now();
      final base64String = await convertXFileToBase64(widget.imageByte!);
      String formattedTime = DateFormat('HH:mm:ss').format(now);
      if (base64String != null && widget.imageByte != null) {
        final mimeType = getMimeType(widget.imageByte!.path);
        return {
          "clockoutTime": formattedTime,
          "clockoutLat": ref.watch(latProvider),
          "clockoutLong": ref.watch(longProvider),
          "clockoutImage": "data:$mimeType;base64,$base64String",
        };
      }
      return {}; // Kembalikan map kosong jika tidak ada file yang diupload
    }

    final attedantProvider = ref.read(attedantSaveProvider(context).notifier);
    String status = ref.watch(statusProvider);

    // Tunggu hasil dari checkIn() atau checkOut() sesuai dengan status
    final data = (status == 'clockin') ? await checkIn() : await checkOut();

    // Mengirim data setelah proses async selesai
    attedantProvider
        .saveData(context: context, data: data, url: ref.watch(statusProvider))
        .then((Response response) {
      final message = response.data['message'];

      if (response.statusCode == 200) {
        notifikasi?.showSuccessToast(message);
        context.pushReplacementNamed('dialogsucces');
      } else {
        notifikasi?.showErrorToast(
            message); // Menggunakan showErrorToast untuk kesalahan
      }
    }).catchError((error) {
      notifikasi?.showErrorToast('Error: $error'); // Menampilkan kesalahan
    });
  }
}

// Helper class for Hex color
class HexColor extends Color {
  HexColor(final String hexColor) : super(_fromHex(hexColor));

  static int _fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}
