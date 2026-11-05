import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/attendance_calculator.dart';
import '../domain/attendance_repository.dart';

class AttendanceException implements Exception {
  final String message;
  const AttendanceException(this.message);

  @override
  String toString() => message;
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AppDatabase _db;

  AttendanceRepositoryImpl(this._db);

  @override
  Future<AttendanceRecord?> getTodayAttendance(int employeeId, String date) {
    return _db.attendanceDao.getTodayAttendance(employeeId, date);
  }

  @override
  Stream<AttendanceRecord?> watchTodayAttendance(int employeeId, String date) {
    return _db.attendanceDao.watchTodayAttendance(employeeId, date);
  }

  @override
  Future<WorkScheduleData?> getTodaySchedule(int employeeId) {
    final now = DateTime.now();
    final weekday = now.weekday; // 1 (Mon) - 7 (Sun)
    return _db.workSchedulesDao.getScheduleForDay(employeeId, weekday);
  }

  @override
  Future<AttendanceRecord> checkIn({
    required int employeeId,
    required bool faceDetected,
    String? photoPath,
  }) async {
    if (!faceDetected) {
      throw const AttendanceException('Face detection is required for check-in.');
    }

    final nowUtc = DateTime.now().toUtc();
    final nowMillis = nowUtc.millisecondsSinceEpoch;
    final todayDate = AttendanceCalculator.formatBusinessDate(DateTime.now());

    return _db.transaction(() async {
      // Check existing attendance for today
      final existing = await _db.attendanceDao.getTodayAttendance(employeeId, todayDate);
      if (existing != null && existing.checkIn != null) {
        throw const AttendanceException('You have already checked in today.');
      }

      // Retrieve employee's schedule for today
      final weekday = DateTime.now().weekday;
      final schedule = await _db.workSchedulesDao.getScheduleForDay(employeeId, weekday);

      // Determine status: late or working
      String status = 'working';
      if (schedule != null && AttendanceCalculator.isLate(DateTime.now(), schedule.startTime)) {
        status = 'late';
      }

      final newId = await _db.attendanceDao.insertAttendance(
        AttendanceCompanion.insert(
          employeeId: employeeId,
          attendanceDate: todayDate,
          checkIn: Value(nowMillis),
          checkInFaceDetected: const Value(1),
          checkInPhotoPath: Value(photoPath),
          status: status,
          createdAt: nowMillis,
          updatedAt: nowMillis,
        ),
      );

      final record = await _db.attendanceDao.getAttendanceById(newId);
      if (record == null) {
        throw const AttendanceException('Failed to retrieve inserted attendance record.');
      }
      return record;
    });
  }

  @override
  Future<AttendanceRecord> checkOut({
    required int employeeId,
    required bool faceDetected,
    String? photoPath,
  }) async {
    if (!faceDetected) {
      throw const AttendanceException('Face detection is required for check-out.');
    }

    final nowUtc = DateTime.now().toUtc();
    final nowMillis = nowUtc.millisecondsSinceEpoch;
    final todayDate = AttendanceCalculator.formatBusinessDate(DateTime.now());

    return _db.transaction(() async {
      final existing = await _db.attendanceDao.getTodayAttendance(employeeId, todayDate);
      if (existing == null || existing.checkIn == null) {
        throw const AttendanceException('Cannot check out without checking in first.');
      }
      if (existing.checkOut != null) {
        throw const AttendanceException('You have already checked out today.');
      }

      if (nowMillis <= existing.checkIn!) {
        throw const AttendanceException('Check-out time cannot be earlier than check-in time.');
      }

      await _db.attendanceDao.updateCheckOut(
        id: existing.id,
        checkOutTime: nowMillis,
        checkOutFaceDetected: 1,
        checkOutPhotoPath: photoPath,
        status: 'completed',
        updatedAt: nowMillis,
      );

      final updated = await _db.attendanceDao.getAttendanceById(existing.id);
      if (updated == null) {
        throw const AttendanceException('Failed to retrieve updated attendance record.');
      }
      return updated;
    });
  }

  @override
  Future<List<AttendanceRecord>> getAttendanceHistory(
    int employeeId, {
    String? month,
    String? date,
  }) {
    return _db.attendanceDao.getAttendanceHistory(employeeId, month: month, date: date);
  }

  @override
  Stream<List<AttendanceRecord>> watchAttendanceHistory(
    int employeeId, {
    String? month,
    String? date,
  }) {
    return _db.attendanceDao.watchAttendanceHistory(employeeId, month: month, date: date);
  }

  @override
  Future<AttendanceRecord?> getAttendanceById(int id) {
    return _db.attendanceDao.getAttendanceById(id);
  }
}
