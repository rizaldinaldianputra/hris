import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/riverpod/user.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider(context));

    return userData.when(
        data: (data) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 50,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            data!.image == null
                                ? const CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        AssetImage('assets/profile.png'),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage:
                                        NetworkImage(data.image ?? ''),
                                  ),
                            const SizedBox(height: 10),
                            Text(
                              '${data.firstName!} ${data.lastName!}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              data.position!.name ?? '',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Information section header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(
                          'Information',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      // Menggunakan input function untuk setiap ListTile
                      input(
                        lead: SvgPicture.asset('assets/account/personal.svg'),
                        title: 'Personal Info',
                        onTap: () {
                          context.goNamed('personalinfo');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),
                      input(
                        lead: SvgPicture.asset('assets/account/employe.svg'),
                        title: 'Employment Info',
                        onTap: () {
                          context.goNamed('employeeinfo');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),
                      input(
                        lead: SvgPicture.asset('assets/account/emergency.svg'),
                        title: 'Emergency Contact Info',
                        onTap: () {
                          context.goNamed('emergencylist');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      input(
                        lead: SvgPicture.asset('assets/account/family.svg'),
                        title: 'Family Info',
                        onTap: () {
                          context.goNamed('familylist');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      input(
                        lead: SvgPicture.asset('assets/account/education.svg'),
                        title: 'Education',
                        onTap: () {
                          context.goNamed('educationlist');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      input(
                        lead: SvgPicture.asset('assets/account/education.svg'),
                        title: 'Organization Experience',
                        onTap: () {
                          context.goNamed('organizationlist');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      input(
                        lead: SvgPicture.asset('assets/account/payrol.svg'),
                        title: 'Payroll Info',
                        onTap: () {
                          context.goNamed('payrollinfo');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      // Settings section header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(
                          'Settings',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      input(
                        lead: SvgPicture.asset('assets/account/change.svg'),
                        title: 'Change Password',
                        onTap: () {
                          context.goNamed('changepassword');
                        },
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      input(
                        lead: SvgPicture.asset('assets/account/langguage.svg'),
                        title: 'Language',
                        onTap: () {},
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      input(
                        lead: SvgPicture.asset('assets/account/help.svg'),
                        title: 'Help Center',
                        onTap: () {},
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      // Other section header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(
                          'Other',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      input(
                        lead: SvgPicture.asset('assets/account/safety.svg'),
                        title: 'Safety & Privacy',
                        onTap: () {},
                      ),
                      Divider(color: HexColor('#EAEAEA')),

                      input(
                        lead: SvgPicture.asset('assets/account/signout.svg'),
                        title: 'Sign Out',
                        onTap: () {
                          ref
                              .watch(userLogoutProvider(context).notifier)
                              .logout(context: context);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )),
                ),
              ],
            ),
          );
        },
        error: (error, stacktrack) {
          return Scaffold(
              body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Terjadi error: $error'),
              ElevatedButton(
                onPressed: () {
                  // Refresh data dengan memanggil provider lagi
                  ref.refresh(userDataProvider(context));
                },
                child: const Text('Coba Lagi'),
              ),
            ],
          ));
        },
        loading: () => const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  Widget input({
    required Widget lead,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            lead, // Gambar atau ikon di sebelah kiri
            const SizedBox(width: 12), // Spasi antar elemen
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
            ), // Ikon di sebelah kanan
          ],
        ),
      ),
    );
  }
}
