class Localization {
  final String languageCode;
  final Map<String, String> strings;

  Localization(this.languageCode, this.strings);
}

class AppLocalizations {
  static final List<Localization> supportedLocales = [
    Localization('en', {
      'attedancelog': 'Attedance \n Log',
      'welcome': 'Welcome',
      'leave_request': 'Leave Request',
      'overtime_request': 'Overtime Request',
      'reimbursement_request': 'Reimbursement Request',
      'earned_wage_access': 'Earned Wage Access',
      'payslip': 'Payslip',
    }),
    Localization('id', {
      'attedancelog': 'Catatan \n Kehadiran',
      'welcome': 'Selamat datang',
      'leave_request': 'Permohonan Cuti',
      'overtime_request': 'Permohonan Lembur',
      'reimbursement_request': 'Permohonan Penggantian Biaya',
      'earned_wage_access': 'Akses Upah yang Diperoleh',
      'payslip': 'Slip Gaji',
    }),
  ];

  static String? translate(String key, String languageCode) {
    final localization = supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
      orElse: () => Localization('en', {}), // Default to English
    );
    return localization.strings[key];
  }
}
