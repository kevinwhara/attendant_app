import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../auth/presentation/auth_providers.dart';

final employeeSchedulesStreamProvider = StreamProvider<List<WorkScheduleData>>((ref) {
  final employee = ref.watch(currentEmployeeProvider);
  if (employee == null) return Stream.value([]);
  final db = ref.watch(appDatabaseProvider);
  return db.workSchedulesDao.watchSchedulesForEmployee(employee.id);
});

final holidaysStreamProvider = StreamProvider<List<HolidayData>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.workSchedulesDao.watchHolidays();
});
