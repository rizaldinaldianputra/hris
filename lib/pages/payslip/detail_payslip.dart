import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hris/utility/globalwidget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PaySlipDetailPage extends ConsumerStatefulWidget {
  const PaySlipDetailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PaySlipDetailPageState();
}

class _PaySlipDetailPageState extends ConsumerState<PaySlipDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Payslip Summary'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Earning Details
              const Text(
                'Earning Details',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRow('Basic Salary', 'Rp 10.000.000'),
              _buildRow('Tax Allowance', 'Rp 876.000'),
              _buildRow('Tunjangan Jabatan', 'Rp 5.000.000'),
              const SizedBox(height: 10),
              const Divider(),
              _buildRow('Total Earnings', 'Rp 15.876.000',
                  isBold: true, isLarge: true),
              const SizedBox(height: 20),

              // Deductions
              const Text(
                'Deductions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRow('BPJS Kesehatan', '- Rp 100.000'),
              _buildRow('JHT Employee', '- Rp 450.000'),
              _buildRow('PPh 21', '- Rp 2.000.000'),
              const SizedBox(height: 10),

              // Additional Deductions
              const Text(
                'Additional Deductions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildRow('Notebook Loan', '- Rp 1.000.000'),
              const SizedBox(height: 10),
              const Divider(),
              _buildRow('Total Deduction', '- Rp 3.550.000',
                  isBold: true, isLarge: true),

              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Take Home Pay',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Center(
                child: Text(
                  'Rp 10.000.000',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          generatePdf(isPrint: false); // Unduh PDF
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: HexColor('#01A2E9')),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.file_download_outlined,
                color: HexColor('#01A2E9'),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Download PDF',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HexColor('#01A2E9')),
              )
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value,
      {bool isBold = false, bool isLarge = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isLarge ? 18 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> generatePdf({bool isPrint = false}) async {
    final pdf = pw.Document();

    // Menambahkan halaman ke PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Earning Details',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            buildPdfRow('Basic Salary', 'Rp 10.000.000'),
            buildPdfRow('Tax Allowance', 'Rp 876.000'),
            buildPdfRow('Tunjangan Jabatan', 'Rp 5.000.000'),
            pw.Divider(),
            buildPdfRow('Total Earnings', 'Rp 15.876.000',
                isBold: true, isLarge: true),
            pw.SizedBox(height: 20),
            pw.Text('Deductions',
                style:
                    pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            buildPdfRow('BPJS Kesehatan', '- Rp 100.000'),
            buildPdfRow('JHT Employee', '- Rp 450.000'),
            buildPdfRow('PPh 21', '- Rp 2.000.000'),
            pw.Divider(),
            buildPdfRow('Total Deduction', '- Rp 3.550.000',
                isBold: true, isLarge: true),
            pw.SizedBox(height: 20),
            pw.Center(
              child: pw.Text(
                'Take Home Pay',
                style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.blue,
                    fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Center(
              child: pw.Text(
                'Rp 10.000.000',
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.black),
              ),
            ),
          ],
        ),
      ),
    );

    if (isPrint) {
      // Jika isPrint true, maka lakukan print
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } else {
      // Jika tidak, unduh PDF
      await Printing.sharePdf(
          bytes: await pdf.save(), filename: 'payslip_summary.pdf');
    }
  }

  pw.Widget buildPdfRow(String title, String value,
      {bool isBold = false, bool isLarge = false}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: isLarge ? 18 : 14,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            fontSize: isLarge ? 18 : 14,
            fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
