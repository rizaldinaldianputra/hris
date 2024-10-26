import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/models/user_model.dart';
import 'package:hris/riverpod/masterdropdown.dart';
import 'package:hris/riverpod/user.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class PersonalInfoPage extends ConsumerStatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalInfoPageState();
}

String? selectedValue;
final List<String> items = [
  'Male',
  'Female',
];
DateTime? selectedDateTime;
PlatformFile? selectedFile;

class _PersonalInfoPageState extends ConsumerState<PersonalInfoPage> {
  String selectedValueGender = '';
  String selectedValueReligion = '';
  String selectedValueNational = '';
  String selectedValueNationality = '';

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider(context));
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nikController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController birthPlaceController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController subDistrictController = TextEditingController();
    TextEditingController districtController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController provinceController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    TextEditingController postalCodeController = TextEditingController();
    TextEditingController birthdayController = TextEditingController();
    return userData.when(error: (error, stackTrace) {
      return Scaffold(
        appBar: appBarWidget('Personal Info'),
        body: Center(child: Text(error.toString())),
      );
    }, loading: () {
      return Scaffold(
        appBar: appBarWidget('Personal Info'),
        body: const Center(child: CircularProgressIndicator()),
      );
    }, data: (data) {
      usernameController.text = data!.username ?? '';
      emailController.text = data.email ?? '';
      phoneController.text = data.phone ?? '';
      nikController.text = data.nik ?? '';
      firstNameController.text = data.firstName ?? '';
      lastNameController.text = data.lastName ?? '';
      birthPlaceController.text = data.birthPlace ?? '';
      addressController.text = data.address ?? '';
      subDistrictController.text = data.subDistrict ?? '';
      districtController.text = data.district ?? '';
      cityController.text = data.city ?? '';
      provinceController.text = data.province ?? '';
      countryController.text = data.country ?? '';
      postalCodeController.text = data.zipCode ?? '';
      selectedValueGender = data.gender ?? items[0];
      birthdayController.text = data.birthDate!;
      final dropdownGender =
          ref.watch(masterDropdownListProvider(context, 'gender'));
      final dropdownReligion =
          ref.watch(masterDropdownListProvider(context, 'religion'));
      final dropdownMaritalStatus =
          ref.watch(masterDropdownListProvider(context, 'marital-status'));
      final dropdownNational =
          ref.watch(masterDropdownListProvider(context, 'nationality'));
      return Scaffold(
        appBar: appBarWidget('Personal Info'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Account Information
                Text(
                  'Account Information',
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 16),
                inputReadOnly(
                  controller: usernameController,
                  hint: 'Username',
                  title: 'Username',
                ),
                inputWidget(
                  iconWidget: SvgPicture.asset(
                    'assets/account/mail.svg',
                    color: HexColor('#363538'),
                  ),
                  controller: emailController,
                  hint: 'Email',
                  title: 'Email',
                ),
                inputWidget(
                  iconWidget: SvgPicture.asset(
                    'assets/account/phone.svg',
                    color: HexColor('#363538'),
                  ),
                  controller: phoneController,
                  hint: 'Phone',
                  title: 'Phone Number',
                ),
                inputWidget(
                  iconWidget: SvgPicture.asset(
                    color: HexColor('#363538'),
                    'assets/account/nik.svg',
                  ),
                  controller: nikController,
                  hint: 'NIK',
                  title: 'NIK',
                ),
                const SizedBox(height: 24),
                Text(
                  'Basic Information',
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 14),
                inputText(
                  controller: firstNameController,
                  hint: 'First Name',
                  title: 'First Name',
                ),
                inputText(
                  controller: lastNameController,
                  hint: 'Last Name',
                  title: 'Last Name',
                ),
                dropdownGender.when(
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () => const CircularProgressIndicator(),
                    data: (data) => dropdownIcon(
                          hinttitle: 'Gender',
                          selectedValue: selectedValueGender,
                          listiem: data,
                          title: 'Gender',
                        )),
                dateTimePicker(
                  'Birth Date',
                  'Choose date',
                  birthdayController,
                  Image.asset('assets/leave/date.png'),
                  context,
                ),
                inputText(
                  controller: birthPlaceController,
                  hint: 'Birth Place',
                  title: 'Birth Place',
                ),
                dropdownReligion.when(
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () => const CircularProgressIndicator(),
                    data: (data) => dropdownIcon(
                          hinttitle: 'Religion',
                          selectedValue: selectedValueReligion,
                          listiem: data,
                          title: 'Religion',
                        )),
                dropdownMaritalStatus.when(
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () => const CircularProgressIndicator(),
                    data: (data) => dropdownIcon(
                          hinttitle: 'Martial Status',
                          selectedValue: selectedValueReligion,
                          listiem: data,
                          title: 'Martial Status',
                        )),
                dropdownNational.when(
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () => const CircularProgressIndicator(),
                    data: (data) => dropdownIcon(
                          hinttitle: 'Nationality',
                          selectedValue: selectedValueNationality,
                          listiem: data,
                          title: 'Nationality',
                        )),
                const SizedBox(height: 8),
                Text(
                  'Upload ',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    height: 40,
                    width: 149,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: HexColor('#757575')),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 18,
                          color: HexColor('#757575'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Upload Image',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: HexColor('#757575'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                if (selectedFile != null && selectedFile!.path != null)
                  Image.file(
                    File(selectedFile!.path!), // Menampilkan file gambar
                    height: 150, // Atur tinggi gambar sesuai kebutuhan
                    width: 150, // Atur lebar gambar sesuai kebutuhan
                    fit: BoxFit.cover, // Mengatur cara gambar diubah ukurannya
                  ),
                const SizedBox(height: 24),
                Text(
                  'Address Information',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Address'),
                const SizedBox(height: 8),
                SizedBox(
                  height: 112,
                  child: TextField(
                    maxLines: 3,
                    controller: addressController,
                    decoration: InputDecoration(
                      hintText: 'Address',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Sudut membulat
                        borderSide: BorderSide(
                          color: HexColor('#D9D9D9'),
                          width: 1, // Border biru
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: HexColor('#D9D9D9'),
                          width: 1, // Border saat aktif
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: HexColor('#D9D9D9'),
                          width: 2, // Border saat fokus
                        ),
                      ),
                    ),
                  ),
                ),
                inputText(
                  title: 'Sub District',
                  controller: subDistrictController,
                  hint: 'Sub District',
                ),
                inputText(
                  title: 'District',
                  controller: districtController,
                  hint: 'District',
                ),
                inputText(
                  title: 'City',
                  controller: cityController,
                  hint: 'City',
                ),
                inputText(
                  title: 'Province',
                  controller: provinceController,
                  hint: 'Province',
                ),
                inputText(
                  title: 'Country',
                  controller: countryController,
                  hint: 'Country',
                ),
                inputText(
                  title: 'Postal Code',
                  controller: postalCodeController,
                  hint: 'Postal Code',
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: bootomSubmit(
          'Submit Request',
          Container(),
          () async {
            UserModel userModel = UserModel.blank();
            userModel.username = usernameController.text;
            userModel.email = emailController.text;
            userModel.phone = phoneController.text;
            userModel.nik = nikController.text;
            userModel.firstName = firstNameController.text;
            userModel.lastName = lastNameController.text;
            userModel.gender = selectedValueGender;
            userModel.birthDate = birthdayController.text;
            userModel.birthPlace = birthPlaceController.text;
            userModel.religion = selectedValueGender;
            userModel.maritalStatus = selectedValueGender;
            userModel.nationality = selectedValueNationality;
            userModel.address = addressController.text;
            userModel.subDistrict = subDistrictController.text;
            userModel.district = districtController.text;
            userModel.city = cityController.text;
            userModel.province = provinceController.text;
            userModel.country = countryController.text;
            userModel.zipCode = postalCodeController.text;
            final response =
                await ref.read(userUpdateProvider(context).notifier).updateData(
                      context: context,
                      data: userModel,
                    );

            // Menghandle response (berhasil atau gagal)
            if (response.statusCode == 200) {
              // Tindakan saat berhasil
              Fluttertoast.showToast(msg: response.data['status']);
            } else {
              // Tindakan saat gagal
              Fluttertoast.showToast(msg: response.data['status']);
            }
          },
        ),
      );
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;

      controller.text = DateFormat('EEEE, dd MMMM yyyy').format(selectedDate);

      DateTime startDate =
          DateFormat('EEEE, dd MMMM yyyy').parse(controller.text);
    }
  }

  Widget dateTimePicker(String title, String hinttitle,
      TextEditingController controller, Widget icons, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                  color: HexColor('#D9D9D9'), width: 1), // Border di semua sisi
              borderRadius: BorderRadius.circular(8.0), // Sudut membulat
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: const EdgeInsets.all(12), // Sesuaikan tinggi ikon
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          color: HexColor('#D9D9D9'),
                          width: 1 // Border kanan pada ikon
                          ),
                    ),
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(8.0),
                    ),
                  ),
                  child: SizedBox(height: 20, width: 20, child: icons),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: true, // Membuat TextField hanya bisa dibaca
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, // Padding di dalam TextField
                      ),
                      hintText: hinttitle,
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: InputBorder
                          .none, // Menghapus border default dari TextField
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDatePickerMode: DatePickerMode.day,
                        initialDate: selectedDateTime ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        selectedDateTime =
                            pickedDate; // Update selectedDateTime
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        controller.text =
                            formattedDate; // Set output date to TextField value.
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dropdownIcon({
    required String title,
    required selectedValue,
    required List listiem,
    required String hinttitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color:
                      HexColor('#D9D9D9')), // Mengatur border untuk keseluruhan
              borderRadius: BorderRadius.circular(10), // Mengatur sudut border
            ),
            child: DropdownButtonFormField<String>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  hinttitle,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: HexColor('#B3B3B3'),
                  ),
                ),
              ),
              value: selectedValue != null && listiem.contains(selectedValue)
                  ? selectedValue
                  : listiem.isNotEmpty
                      ? listiem[0]
                      : null,
              items: listiem.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, left: 20.0),
                    child: Text(item),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none, // Menghilangkan border default
                enabledBorder:
                    InputBorder.none, // Menghilangkan border saat aktif
                focusedBorder:
                    InputBorder.none, // Menghilangkan border saat fokus
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    // Meminta izin akses penyimpanan
    var status = await Permission.storage.request();

    // Cek status izin
    if (status.isGranted) {
      // Jika izin diberikan, pilih file
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          selectedFile = result.files.single; // Ambil file yang dipilih
        });
      }
    } else if (status.isDenied) {
      // Jika izin ditolak
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    } else if (status.isPermanentlyDenied) {
      // Jika izin ditolak secara permanen, minta pengguna untuk mengatur izin di pengaturan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Storage permission permanently denied. Please enable it in settings.')),
      );
      // Tampilkan dialog untuk mengarahkan pengguna ke pengaturan
      openAppSettings();
    }
  }
}
