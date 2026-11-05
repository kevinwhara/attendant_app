import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/attendance_table.dart';

part 'attendance_dao.g.dart';

@DriftAccessor(tables: [Attendance])
class AttendanceDao extends DatabaseAccessor<AppDatabase> with _$AttendanceDaoMixin {
  AttendanceDao(super.db);

  Future<AttendanceRecord?> getTodayAttendance(int employeeId, String date) {
    return (select(attendance)
          ..where((tbl) =>
              tbl.employeeId.equals(employeeId) &
              tbl.attendanceDate.equals(date)))
        .getSingleOrNull();
  }

  Stream<AttendanceRecord?> watchTodayAttendance(int employeeId, String date) {
    return (select(attendance)
          ..where((tbl) =>
              tbl.employeeId.equals(employeeId) &
              tbl.attendanceDate.equals(date)))
        .watchSingleOrNull();
  }

  Future<AttendanceRecord?> getAttendanceById(int id) {
    return (select(attendance)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertAttendance(AttendanceCompanion entry) {
    return into(attendance).insert(entry);
  }

  Future<bool> updateAttendance(AttendanceCompanion entry) {
    return update(attendance).replace(entry);
  }

  Future<int> updateCheckOut({
    required int id,
    required int checkOutTime,
    required int checkOutFaceDetected,
    String? checkOutPhotoPath,
    required String status,
    required int updatedAt,
  }) {
    return (update(attendance)..where((tbl) => tbl.id.equals(id))).write(
      AttendanceCompanion(
        checkOut: Value(checkOutTime),
        checkOutFaceDetected: Value(checkOutFaceDetected),
        checkOutPhotoPath: Value(checkOutPhotoPath),
        status: Value(status),
        updatedAt: Value(updatedAt),
      ),
    );
  }

  Future<List<AttendanceRecord>> getAttendanceHistory(
    int employeeId, {
    String? month, // YYYY-MM
    String? date,  // YYYY-MM-DD
  }) {
    final query = select(attendance)
      ..where((tbl) => tbl.employeeId.equals(employeeId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.attendanceDate, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ]);

    if (date != null && date.isNotEmpty) {
      query.where((tbl) => tbl.attendanceDate.equals(date));
    } else if (month != null && month.isNotEmpty) {
      query.where((tbl) => tbl.attendanceDate.like('$month%'));
    }

    return query.get();
  }

  Stream<List<AttendanceRecord>> watchAttendanceHistory(
    int employeeId, {
    String? month,
    String? date,
  }) {
    final query = select(attendance)
      ..where((tbl) => tbl.employeeId.equals(employeeId))
      ..orderBy([
        (t) => OrderingTerm(expression: t.attendanceDate, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
      ]);

    if (date != null && date.isNotEmpty) {
      query.where((tbl) => tbl.attendanceDate.equals(date));
    } else if (month != null && month.isNotEmpty) {
      query.where((tbl) => tbl.attendanceDate.like('$month%'));
    }

    return query.watch();
  }
}

