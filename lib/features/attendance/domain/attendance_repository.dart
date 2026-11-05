import '../../../core/database/app_database.dart';

abstract class AttendanceRepository {
  Future<AttendanceRecord?> getTodayAttendance(int employeeId, String date);
  Stream<AttendanceRecord?> watchTodayAttendance(int employeeId, String date);
  Future<WorkScheduleData?> getTodaySchedule(int employeeId);
  Future<AttendanceRecord> checkIn({
    required int employeeId,
    required bool faceDetected,
    String? photoPath,
  });
  Future<AttendanceRecord> checkOut({
    required int employeeId,
    required bool faceDetected,
    String? photoPath,
  });
  Future<List<AttendanceRecord>> getAttendanceHistory(
    int employeeId, {
    String? month,
    String? date,
  });
  Stream<List<AttendanceRecord>> watchAttendanceHistory(
    int employeeId, {
    String? month,
    String? date,
  });
  Future<AttendanceRecord?> getAttendanceById(int id);
}
