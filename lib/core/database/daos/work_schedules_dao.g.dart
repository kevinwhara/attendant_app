// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_schedules_dao.dart';

// ignore_for_file: type=lint
mixin _$WorkSchedulesDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmployeesTable get employees => attachedDatabase.employees;
  $WorkSchedulesTable get workSchedules => attachedDatabase.workSchedules;
  $HolidaysTable get holidays => attachedDatabase.holidays;
  WorkSchedulesDaoManager get managers => WorkSchedulesDaoManager(this);
}

class WorkSchedulesDaoManager {
  final _$WorkSchedulesDaoMixin _db;
  WorkSchedulesDaoManager(this._db);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db.attachedDatabase, _db.employees);
  $$WorkSchedulesTableTableManager get workSchedules =>
      $$WorkSchedulesTableTableManager(_db.attachedDatabase, _db.workSchedules);
  $$HolidaysTableTableManager get holidays =>
      $$HolidaysTableTableManager(_db.attachedDatabase, _db.holidays);
}
