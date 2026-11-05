import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:updated_attendant_app/core/database/app_database.dart';
import 'package:updated_attendant_app/core/utils/attendance_calculator.dart';
import 'package:updated_attendant_app/features/attendance/data/attendance_repository_impl.dart';

void main() {
  late AppDatabase db;
  late AttendanceRepositoryImpl attendanceRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    attendanceRepo = AttendanceRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Attendance Business Logic Tests', () {
    test('Check-in succeeds with face detected', () async {
      final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
      expect(employee, isNotNull);

      final record = await attendanceRepo.checkIn(
        employeeId: employee!.id,
        faceDetected: true,
      );

      expect(record.checkIn, isNotNull);
      expect(record.checkInFaceDetected, equals(1));
      expect(record.status, anyOf('working', 'late'));
    });

    test('Check-in rejected when face is not detected', () async {
      final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
      expect(
        () => attendanceRepo.checkIn(
          employeeId: employee!.id,
          faceDetected: false,
        ),
        throwsA(isA<AttendanceException>()),
      );
    });

    test('Duplicate check-in on the same day is rejected', () async {
      final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
      await attendanceRepo.checkIn(
        employeeId: employee!.id,
        faceDetected: true,
      );

      expect(
        () => attendanceRepo.checkIn(
          employeeId: employee.id,
          faceDetected: true,
        ),
        throwsA(isA<AttendanceException>()),
      );
    });

    test('Check-out without check-in is rejected', () async {
      final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
      expect(
        () => attendanceRepo.checkOut(
          employeeId: employee!.id,
          faceDetected: true,
        ),
        throwsA(isA<AttendanceException>()),
      );
    });

    test('Successful check-out after check-in', () async {
      final employee = await db.employeesDao.getEmployeeByCodeOrEmail('EMP001');
      await attendanceRepo.checkIn(
        employeeId: employee!.id,
        faceDetected: true,
      );

      final checkoutRecord = await attendanceRepo.checkOut(
        employeeId: employee.id,
        faceDetected: true,
      );

      expect(checkoutRecord.checkOut, isNotNull);
      expect(checkoutRecord.status, equals('completed'));
      expect(checkoutRecord.checkOutFaceDetected, equals(1));

      // Duplicate check-out is rejected
      expect(
        () => attendanceRepo.checkOut(
          employeeId: employee.id,
          faceDetected: true,
        ),
        throwsA(isA<AttendanceException>()),
      );
    });

    test('Late calculation logic', () {
      final today = DateTime.now();
      final onTime = DateTime(today.year, today.month, today.day, 7, 55);
      final lateTime = DateTime(today.year, today.month, today.day, 8, 15);

      expect(AttendanceCalculator.isLate(onTime, '08:00'), isFalse);
      expect(AttendanceCalculator.isLate(lateTime, '08:00'), isTrue);
    });

    test('Working duration with overlapping break', () {
      final today = DateTime.now();
      final checkIn = DateTime(today.year, today.month, today.day, 8, 0);
      final checkOut = DateTime(today.year, today.month, today.day, 17, 0);

      // Total 9 hours (08:00 to 17:00), break is 12:00 to 13:00 (1 hour). Working duration should be 8 hours.
      final duration = AttendanceCalculator.calculateWorkingDuration(
        checkIn: checkIn,
        checkOut: checkOut,
        breakStartStr: '12:00',
        breakEndStr: '13:00',
      );

      expect(duration.inHours, equals(8));
      expect(AttendanceCalculator.formatDuration(duration), equals('8h 0m'));
    });
  });
}
