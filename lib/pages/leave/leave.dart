import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/helper/status_color.dart';
import 'package:hris/riverpod/leave.dart';

import 'package:hris/utility/globalwidget.dart';
import 'package:intl/intl.dart';

class LeavePage extends ConsumerStatefulWidget {
  const LeavePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LeavePageState();
}

class _LeavePageState extends ConsumerState<LeavePage> {
  @override
  Widget build(BuildContext context) {
    final leaveListFuture = ref.watch(leaveListViewProvider(context));

    return Scaffold(
        appBar:
            appBarWidgetWithTralling('Leave', Image.asset('assets/filter.png')),
        body: leaveListFuture.when(
            data: (leaveList) {
              // Jika data ada
              if (leaveList.isEmpty) {
                return const Center(
                  child: Text('No leaves found'),
                );
              }
              return ListView.builder(
                itemCount: leaveList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 1, color: HexColor('#EAEAEA')),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 300,
                              child: Text(
                                leaveList[index].leaveType!.name ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                              ),
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
                          formatDate(leaveList[index].date!),
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
                              color: statusColor(leaveList[index].status!),
                              child: Text(
                                leaveList[index].status!,
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
              );
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            error: (error, stack) => Scaffold(
                    body: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.blue,
                      size: 40,
                    ), // Ikon refresh
                    onPressed: () {
                      // Panggil fungsi refresh di sini
                      ref.refresh(leaveListViewProvider(context));
                    },
                  ),
                ))),
        bottomNavigationBar: bootomSubmit(
            'Leave Request',
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            () => context.goNamed('requestleave')));
  }
}

String formatDate(String date) {
  // Mengonversi string ke DateTime
  DateTime parsedDate = DateTime.parse(date);
  // Format ulang ke dd MMM yyyy
  String formattedDate = DateFormat('dd MMM yyyy').format(parsedDate);
  return formattedDate;
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