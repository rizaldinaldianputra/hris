import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CamerPreviewPage extends ConsumerStatefulWidget {
  final XFile? imageByte;
  const CamerPreviewPage({super.key, required this.imageByte});

  @override
  ConsumerState<CamerPreviewPage> createState() => _CamerPreviewPageState();
}

class _CamerPreviewPageState extends ConsumerState<CamerPreviewPage> {
  Uint8List? fileImage;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBarWidget('Attendance Log'),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // Shift Information Section
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
                        Text('Morning shift',
                            style:
                                GoogleFonts.inter(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('21 Jun 2024 (10:00 - 17:00)',
                            style: GoogleFonts.inter()),
                      ],
                    ),
                  ),
                ),

                // Image Section
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
                      context.goNamed('dialogsucces');
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
