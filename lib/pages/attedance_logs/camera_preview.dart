import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/pages/attedance_logs/dialog_succes.dart';
import 'package:hris/pages/attedance_logs/maps_location.dart';
import 'package:hris/riverpod/attedant.dart';
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

  bool isSubmitting = false; // Status untuk mencegah pengiriman ganda
  bool isLoading = false;
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
              icon: const Icon(Icons.refresh),
            ),
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
                                fit: BoxFit.fill,
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
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
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => const MapsLocations());
                        },
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
                      (isLoading)
                          ? Container(
                              margin: const EdgeInsets.all(20),
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSubmitting
                                    ? Colors
                                        .grey // Mengubah warna saat sedang menunggu respons
                                    : HexColor('#01A2E9'),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
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
                            )
                          : GestureDetector(
                              onTap: () {
                                if (!isSubmitting) {
                                  submitAttedant();
                                }
                              },
                              child: AbsorbPointer(
                                absorbing:
                                    isSubmitting, // Menonaktifkan interaksi
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: isSubmitting
                                        ? Colors
                                            .grey // Mengubah warna saat sedang menunggu respons
                                        : HexColor('#01A2E9'),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: Center(
                                    child: isSubmitting
                                        ? const CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          )
                                        : Text(
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
    if (isSubmitting) return; // Mencegah panggilan ganda
    isSubmitting = true; // Menandai bahwa pengiriman sedang berlangsung
    setState(() {
      isLoading = true;
    });
    try {
      DateTime now = DateTime.now();
      final base64String = await convertXFileToBase64(widget.imageByte!);
      String formattedTime = DateFormat('HH:mm:ss').format(now);
      String? mimeType = getMimeType(widget.imageByte!.path);

      Map<String, dynamic> data;

      String status = ref.read(statusProvider);
      if (status == 'clockin') {
        data = {
          "clockinTime": formattedTime,
          "clockinLat": ref.read(latProvider),
          "clockinLong": ref.read(longProvider),
          "clockinImage": "data:$mimeType;base64,$base64String",
        };
      } else {
        data = {
          "clockoutTime": formattedTime,
          "clockoutLat": ref.read(latProvider),
          "clockoutLong": ref.read(longProvider),
          "clockoutImage": "data:$mimeType;base64,$base64String",
        };
      }

      final attedantProvider = ref.read(attedantSaveProvider(context).notifier);

      // Mengirim data setelah proses async selesai
      final response = await attedantProvider.saveData(
        context: context,
        data: data,
        url: ref.read(statusProvider),
      );

      final message = response.data['message'];

      if (response.statusCode == 200) {
        isLoading = false;

        notifikasi?.showSuccessToast(message);
        context.goNamed('dialogsucces');
      } else {
        setState(() {
          isLoading = false;
        });
        notifikasi?.showErrorToast(message);
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      notifikasi?.showErrorToast('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
      isSubmitting = false; // Reset status setelah proses selesai
    }
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
