import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/work_schedules_table.dart';
import '../tables/holidays_table.dart';

part 'work_schedules_dao.g.dart';

@DriftAccessor(tables: [WorkSchedules, Holidays])
class WorkSchedulesDao extends DatabaseAccessor<AppDatabase> with _$WorkSchedulesDaoMixin {
  WorkSchedulesDao(super.db);

  Future<List<WorkScheduleData>> getSchedulesForEmployee(int employeeId) {
    return (select(workSchedules)
          ..where((tbl) => tbl.employeeId.equals(employeeId))
          ..orderBy([(t) => OrderingTerm(expression: t.dayOfWeek)]))
        .get();
  }

  Stream<List<WorkScheduleData>> watchSchedulesForEmployee(int employeeId) {
    return (select(workSchedules)
          ..where((tbl) => tbl.employeeId.equals(employeeId))
          ..orderBy([(t) => OrderingTerm(expression: t.dayOfWeek)]))
        .watch();
  }

  Future<WorkScheduleData?> getScheduleForDay(int employeeId, int dayOfWeek) {
    return (select(workSchedules)
          ..where((tbl) =>
              tbl.employeeId.equals(employeeId) &
              tbl.dayOfWeek.equals(dayOfWeek)))
        .getSingleOrNull();
  }

  Future<List<HolidayData>> getHolidays() {
    return (select(holidays)
          ..orderBy([(t) => OrderingTerm(expression: t.holidayDate)]))
        .get();
  }

  Stream<List<HolidayData>> watchHolidays() {
    return (select(holidays)
          ..orderBy([(t) => OrderingTerm(expression: t.holidayDate)]))
        .watch();
  }
}
