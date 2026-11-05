import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../attendance/presentation/attendance_providers.dart';
import '../../auth/presentation/auth_providers.dart';

class HistoryFilter {
  final String? month; // YYYY-MM
  final String? date;  // YYYY-MM-DD

  const HistoryFilter({this.month, this.date});

  HistoryFilter copyWith({String? Function()? month, String? Function()? date}) {
    return HistoryFilter(
      month: month != null ? month() : this.month,
      date: date != null ? date() : this.date,
    );
  }
}

class HistoryFilterNotifier extends Notifier<HistoryFilter> {
  @override
  HistoryFilter build() {
    return const HistoryFilter();
  }

  void setFilter(HistoryFilter filter) {
    state = filter;
  }

  void clear() {
    state = const HistoryFilter();
  }
}

final historyFilterProvider = NotifierProvider<HistoryFilterNotifier, HistoryFilter>(() {
  return HistoryFilterNotifier();
});

final attendanceHistoryStreamProvider = StreamProvider<List<AttendanceRecord>>((ref) {
  final employee = ref.watch(currentEmployeeProvider);
  if (employee == null) return Stream.value([]);

  final filter = ref.watch(historyFilterProvider);
  final repo = ref.watch(attendanceRepositoryProvider);

  return repo.watchAttendanceHistory(
    employee.id,
    month: filter.month,
    date: filter.date,
  );
});
