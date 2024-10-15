import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hris/models/attedance_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attedant.g.dart';

@riverpod
class AttendanceNotifier extends _$AttendanceNotifier {
  @override
  List<Attendance> build() {
    return []; // State awal
  }

  void addAttendance(Attendance attendance) {
    state = [...state, attendance];
  }

  void removeAttendance(String id) {
    state = state.where((attendance) => attendance.id != id).toList();
  }

  void updateAttendance(Attendance updatedAttendance) {
    state = state.map((attendance) {
      return attendance.id == updatedAttendance.id
          ? updatedAttendance
          : attendance;
    }).toList();
  }
}
