import 'package:drift/drift.dart';
import 'employees_table.dart';

@DataClassName('AttendanceRecord')
class Attendance extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get employeeId => integer().references(Employees, #id)();
  TextColumn get attendanceDate => text()(); // YYYY-MM-DD
  IntColumn get checkIn => integer().nullable()(); // UTC Unix ms
  IntColumn get checkOut => integer().nullable()(); // UTC Unix ms
  IntColumn get checkInFaceDetected => integer().withDefault(const Constant(0))(); // 0 or 1
  IntColumn get checkOutFaceDetected => integer().withDefault(const Constant(0))(); // 0 or 1
  TextColumn get checkInPhotoPath => text().nullable()();
  TextColumn get checkOutPhotoPath => text().nullable()();
  TextColumn get status => text()(); // 'not_checked_in', 'working', 'completed', 'late'
  TextColumn get notes => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {employeeId, attendanceDate},
  ];
}
