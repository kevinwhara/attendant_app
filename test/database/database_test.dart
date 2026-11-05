import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/core/utils/hash_util.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('Database seeds demo employee, schedules and holidays', () async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
    expect(employee, isNotNull);
    expect(employee!.name, equals('Demo Employee'));
    expect(employee.email, equals('employee@attendant.local'));
    expect(HashUtil.verifyPassword('Attendant123!', employee.passwordHash), isTrue);

    final schedules = await db.workSchedulesDao.getSchedulesForEmployee(employee.id);
    expect(schedules.length, equals(5));

    final holidays = await db.workSchedulesDao.getHolidays();
    expect(holidays.isNotEmpty, isTrue);
  });

  test('Enforces unique constraint on attendance date per employee', () async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
    expect(employee, isNotNull);

    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    await db.attendanceDao.insertAttendance(
      AttendanceCompanion.insert(
        employeeId: employee!.id,
        attendanceDate: '2026-11-05',
        checkIn: Value(now),
        checkInFaceDetected: const Value(1),
        status: 'working',
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Duplicate insertion on same date for same employee should fail
    expect(
      () => db.attendanceDao.insertAttendance(
        AttendanceCompanion.insert(
          employeeId: employee.id,
          attendanceDate: '2026-11-05',
          checkIn: Value(now),
          status: 'working',
          createdAt: now,
          updatedAt: now,
        ),
      ),
      throwsException,
    );
  });

  test('Attendance checkout update works', () async {
    final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    final id = await db.attendanceDao.insertAttendance(
      AttendanceCompanion.insert(
        employeeId: employee!.id,
        attendanceDate: '2026-11-05',
        checkIn: Value(now),
        checkInFaceDetected: const Value(1),
        status: 'working',
        createdAt: now,
        updatedAt: now,
      ),
    );

    final checkOutTime = now + 8 * 3600 * 1000;
    await db.attendanceDao.updateCheckOut(
      id: id,
      checkOutTime: checkOutTime,
      checkOutFaceDetected: 1,
      status: 'completed',
      updatedAt: checkOutTime,
    );

    final record = await db.attendanceDao.getTodayAttendance(employee.id, '2026-11-05');
    expect(record, isNotNull);
    expect(record!.checkOut, equals(checkOutTime));
    expect(record.status, equals('completed'));
    expect(record.checkOutFaceDetected, equals(1));
  });
}
