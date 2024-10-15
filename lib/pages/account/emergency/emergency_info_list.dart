import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:go_router/go_router.dart';

class EmergencyInfoListPage extends ConsumerStatefulWidget {
  const EmergencyInfoListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmergencyInfoListPageState();
}

class _EmergencyInfoListPageState extends ConsumerState<EmergencyInfoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Emergency Contact'),
      body: Padding(
        padding: const EdgeInsets.all(
          16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'List Emergency Contact',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Center(
              child: Container(
                height: 527,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/emergency.png'),
                    Text(
                      'There is no emergency contact yet',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "You haven't added emergency contacts yet. Add emergency contacts via the button below",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: HexColor('#878787'),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed('emergencyadd');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: HexColor('#3699FF'),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Add Contact Emergency',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: HexColor('#3699FF')),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}