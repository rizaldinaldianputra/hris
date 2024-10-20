class AttedanceSummaryModel {
  final int absent;
  final int lateClockin;
  final int earlyClockin;
  final int noClockin;
  final int noClockout;

  AttedanceSummaryModel({
    required this.absent,
    required this.lateClockin,
    required this.earlyClockin,
    required this.noClockin,
    required this.noClockout,
  });

  // Factory method untuk membuat instance dari JSON
  factory AttedanceSummaryModel.fromJson(Map<String, dynamic> json) {
    return AttedanceSummaryModel(
      absent: json['absent'] ?? 0,
      lateClockin: json['lateClockin'] ?? 0,
      earlyClockin: json['earlyClockin'] ?? 0,
      noClockin: json['noClockin'] ?? 0,
      noClockout: json['noClockout'] ?? 0,
    );
  }

  // Method untuk mengubah instance menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'absent': absent,
      'lateClockin': lateClockin,
      'earlyClockin': earlyClockin,
      'noClockin': noClockin,
      'noClockout': noClockout,
    };
  }
}
