import 'package:drift/drift.dart';
import '../utils/hash_util.dart';
import 'database_connection.dart';
import 'tables/employees_table.dart';
import 'tables/attendance_table.dart';
import 'tables/work_schedules_table.dart';
import 'tables/holidays_table.dart';
import 'tables/app_settings_table.dart';
import 'daos/employees_dao.dart';
import 'daos/attendance_dao.dart';
import 'daos/work_schedules_dao.dart';
import 'daos/app_settings_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Employees, Attendance, WorkSchedules, Holidays, AppSettings],
  daos: [EmployeesDao, AttendanceDao, WorkSchedulesDao, AppSettingsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? openAppDatabaseConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await _seedData();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
      final count = await (select(employees)..limit(1)).get();
      if (count.isEmpty) {
        await _seedData();
      }
    },
  );

  Future<void> _seedData() async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    // Seed Demo Employee: EMP001, Attendant123!
    final demoPasswordHash = HashUtil.hashPassword('Attendant123!');
    final employeeId = await into(employees).insert(
      EmployeesCompanion.insert(
        employeeCode: 'EMP001',
        name: 'Demo Employee',
        email: 'employee@attendant.local',
        passwordHash: demoPasswordHash,
        department: const Value('Engineering'),
        position: const Value('Senior Software Engineer'),
        createdAt: now,
        updatedAt: now,
      ),
    );

    // Seed default weekly work schedule: Monday(1) to Friday(5)
    for (int day = 1; day <= 5; day++) {
      await into(workSchedules).insert(
        WorkSchedulesCompanion.insert(
          employeeId: employeeId,
          dayOfWeek: day,
          startTime: '08:00',
          endTime: '17:00',
          breakStart: const Value('12:00'),
          breakEnd: const Value('13:00'),
        ),
      );
    }

    // Seed sample holidays
    final sampleHolidays = [
      HolidaysCompanion.insert(
        name: "New Year's Day",
        holidayDate: '2026-01-01',
        description: const Value('Public Holiday'),
      ),
      HolidaysCompanion.insert(
        name: 'Eid al-Fitr',
        holidayDate: '2026-03-21',
        description: const Value('National Religious Holiday'),
      ),
      HolidaysCompanion.insert(
        name: 'Labor Day',
        holidayDate: '2026-05-01',
        description: const Value('International Workers Day'),
      ),
      HolidaysCompanion.insert(
        name: 'Independence Day',
        holidayDate: '2026-08-17',
        description: const Value('National Independence Day'),
      ),
      HolidaysCompanion.insert(
        name: 'Christmas Day',
        holidayDate: '2026-12-25',
        description: const Value('National Religious Holiday'),
      ),
    ];

    for (final holiday in sampleHolidays) {
      await into(holidays).insert(holiday);
    }

    // Initial app settings
    await into(appSettings).insert(
      AppSettingsCompanion.insert(
        settingKey: 'app_initialized',
        settingValue: 'true',
      ),
    );
  }
}

