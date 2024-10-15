import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/status_color.dart';

import 'package:hris/utility/globalwidget.dart';

class LeavePage extends ConsumerStatefulWidget {
  const LeavePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeavePageState();
}

class _LeavePageState extends ConsumerState<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            appBarWidgetWithTralling('Leave', Image.asset('assets/filter.png')),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: HexColor('#EAEAEA')),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sick leave request',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '03 Aug 2024 - 29 Aug 2024',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        color: statusColor('Rejected'),
                        child: Text(
                          'Rejected',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: statusColorText('Rejected'),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: bootomSubmit(
            'Overtime Request',
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            () => context.goNamed('requestleave')));
  }
}



  //  PagedListView<int, LeaveModel>(
  //           shrinkWrap: true,
  //           pagingController: ref.watch(
  //               leaveListProvider(context)), // Ensure proper provider access
  //           builderDelegate: PagedChildBuilderDelegate<LeaveModel>(
  //             itemBuilder: (context, item, index) {
  //               return GestureDetector(
  //                 onTap: () {},
  //               );
  //             },
  //             firstPageProgressIndicatorBuilder: (context) =>
  //                 const Center(child: CircularProgressIndicator()),
  //             newPageProgressIndicatorBuilder: (context) =>
  //                 const Center(child: CircularProgressIndicator()),
  //             noItemsFoundIndicatorBuilder: (context) => const Center(
  //                 child: Text(
  //               'No items found',
  //               style: TextStyle(color: Colors.white),
  //             )),
  //           ),
  //         ),