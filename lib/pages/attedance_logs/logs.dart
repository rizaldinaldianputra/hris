import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LogsPage extends ConsumerStatefulWidget {
  const LogsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogsPageState();
}

class _LogsPageState extends ConsumerState<LogsPage> {
  String selectedMonthFilter = 'Januari'; // State untuk bulan yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: double.infinity, // Membuat lebar dropdown penuh
                child: DropdownButtonFormField<String>(
                  value: selectedMonthFilter,
                  isExpanded:
                      true, // Memperluas dropdown untuk tampilan yang lebih baik
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Membulatkan sudut
                      borderSide: const BorderSide(
                        color: Colors.grey, // Warna border
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border saat fokus
                        width: 0.3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey, // Border saat fokus
                        width: 0.3,
                      ),
                    ),
                    prefixIcon: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(color: Colors.grey, width: 0.3))),
                      child: const Icon(
                        Icons.calendar_today, // Ikon di depan (prefix)
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  items: <String>[
                    'Januari',
                    'Februari',
                    'Maret',
                    'April',
                    'Mei',
                    'Juni',
                    'Juli',
                    'Agustus',
                    'September',
                    'Oktober',
                    'November',
                    'Desember',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Text(value)),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMonthFilter =
                          newValue!; // Mengupdate filter bulan yang dipilih
                    });
                  },
                  icon: const Icon(
                    Icons
                        .arrow_drop_down, // Menambahkan ikon dropdown di ujung kanan
                    color: Colors.grey, // Warna ikon
                    size: 24, // Ukuran ikon
                  ),
                  dropdownColor: Colors.white, // Warna dropdown
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(width: 0.3, color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2, // Rasio antara lebar dan tinggi item
                  crossAxisSpacing: 20.0, // Jarak horizontal antar item
                  mainAxisSpacing: 20.0, // Jarak vertikal antar item

                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    itemCardGrid('2', 'Absent'),
                    itemCardGrid('1', 'Late Clock-in'),
                    itemCardGrid('0', 'Early Clock-in'),
                    itemCardGrid('0', 'No Clock-in'),
                    itemCardGrid('0', 'No Clock-out'),
                  ]),
            ),

            // ListView di bawah
            Container(
              height:
                  MediaQuery.of(context).size.height * 0.5, // Sesuaikan tinggi
              margin: const EdgeInsets.all(15), // Margin untuk container
              decoration: BoxDecoration(
                border: Border.all(
                    width: 0.3, color: Colors.grey), // Batasan border
                borderRadius: const BorderRadius.all(
                    Radius.circular(8)), // Sudut membulat
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(); // Garis pemisah antar item
                },
                shrinkWrap: true, // Menyusut sesuai isi
                itemCount: 20, // Jumlah item
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 50, // Tinggi masing-masing item
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Ruang antar elemen
                      children: [
                        // Bagian kiri: menampilkan judul item
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start, // Mulai dari kiri
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Pusatkan vertikal
                            children: [
                              Text(
                                'Item ${index + 1}', // Menampilkan nomor item
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Filter: $selectedMonthFilter', // Menampilkan filter bulan
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        // Bagian kanan: Menampilkan tanggal
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '20 Jun', // Tanggal
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '20 Jun', // Tanggal
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemCardGrid(String count, String title) {
    return Column(children: [
      Container(
        height: 50,
        width: 50,
        decoration:
            BoxDecoration(color: HexColor('#F7F7F7'), shape: BoxShape.circle),
        child: Center(
            child: Text(
          count,
          style: GoogleFonts.inter(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        )),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(title,
          style: GoogleFonts.inter(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.w400, fontSize: 12)))
    ]);
  }
}
