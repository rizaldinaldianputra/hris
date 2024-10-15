import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:go_router/go_router.dart';

class DialogSuccesPage extends ConsumerStatefulWidget {
  const DialogSuccesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DialogSuccesPageState();
}

class _DialogSuccesPageState extends ConsumerState<DialogSuccesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/iconsuccess.png',
              width: 54,
              height: 54,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Clock In Successful',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: HexColor('#01A2E9')),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '09:45',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Schedule: 21 Juni 2024',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: HexColor('#878787')),
            ),
            Text(
              'Working Hours',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: HexColor('#878787')),
            ),
            Text(
              '10:00-17:00',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: HexColor('#878787')),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 138,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  context.goNamed('home');
                },
                child: Container(
                    margin: const EdgeInsets.only(
                        top: 24, left: 16, right: 16, bottom: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        color: HexColor('#01A2E9'),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Center(
                        child: Text(
                      'Back to Home',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ))),
              ),
              TextButton(
                  onPressed: () {}, child: const Text('View Attendace Log')),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
