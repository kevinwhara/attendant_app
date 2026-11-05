import 'package:drift/drift.dart';
import 'employees_table.dart';

@DataClassName('WorkScheduleData')
class WorkSchedules extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get employeeId => integer().references(Employees, #id)();
  IntColumn get dayOfWeek => integer()(); // ISO 1-7 (1 = Monday, 7 = Sunday)
  TextColumn get startTime => text()(); // e.g. '08:00'
  TextColumn get endTime => text()(); // e.g. '17:00'
  TextColumn get breakStart => text().nullable()(); // e.g. '12:00'
  TextColumn get breakEnd => text().nullable()(); // e.g. '13:00'

  @override
  List<Set<Column>> get uniqueKeys => [
    {employeeId, dayOfWeek},
  ];
}

