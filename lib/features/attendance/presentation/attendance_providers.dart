import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/utils/attendance_calculator.dart';
import '../../auth/presentation/auth_providers.dart';
import '../data/attendance_repository_impl.dart';
import '../domain/attendance_repository.dart';

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return AttendanceRepositoryImpl(db);
});

final todayAttendanceProvider = StreamProvider<AttendanceRecord?>((ref) {
  final employee = ref.watch(currentEmployeeProvider);
  if (employee == null) return Stream.value(null);

  final today = AttendanceCalculator.formatBusinessDate(DateTime.now());
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.watchTodayAttendance(employee.id, today);
});

final todayScheduleProvider = FutureProvider<WorkScheduleData?>((ref) async {
  final employee = ref.watch(currentEmployeeProvider);
  if (employee == null) return null;
  final repo = ref.watch(attendanceRepositoryProvider);
  return repo.getTodaySchedule(employee.id);
});

class AttendanceActionState {
  final bool isLoading;
  final String? errorMessage;
  final AttendanceRecord? lastRecord;

  const AttendanceActionState({
    this.isLoading = false,
    this.errorMessage,
    this.lastRecord,
  });
}

class AttendanceController extends Notifier<AttendanceActionState> {
  late final AttendanceRepository _repo;

  @override
  AttendanceActionState build() {
    _repo = ref.watch(attendanceRepositoryProvider);
    return const AttendanceActionState();
  }

  Future<bool> checkIn({required bool faceDetected, String? photoPath}) async {
    final employee = ref.read(currentEmployeeProvider);
    if (employee == null) {
      state = const AttendanceActionState(errorMessage: 'Employee not authenticated');
      return false;
    }

    state = const AttendanceActionState(isLoading: true);
    try {
      final record = await _repo.checkIn(
        employeeId: employee.id,
        faceDetected: faceDetected,
        photoPath: photoPath,
      );
      state = AttendanceActionState(lastRecord: record);
      ref.invalidate(todayAttendanceProvider);
      return true;
    } catch (e) {
      state = AttendanceActionState(errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> checkOut({required bool faceDetected, String? photoPath}) async {
    final employee = ref.read(currentEmployeeProvider);
    if (employee == null) {
      state = const AttendanceActionState(errorMessage: 'Employee not authenticated');
      return false;
    }

    state = const AttendanceActionState(isLoading: true);
    try {
      final record = await _repo.checkOut(
        employeeId: employee.id,
        faceDetected: faceDetected,
        photoPath: photoPath,
      );
      state = AttendanceActionState(lastRecord: record);
      ref.invalidate(todayAttendanceProvider);
      return true;
    } catch (e) {
      state = AttendanceActionState(errorMessage: e.toString());
      return false;
    }
  }
}

final attendanceControllerProvider =
    NotifierProvider<AttendanceController, AttendanceActionState>(() {
  return AttendanceController();
});
