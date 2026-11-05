import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/database/app_database.dart';
import 'schedule_providers.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  static const _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(employeeSchedulesStreamProvider);
    final holidaysAsync = ref.watch(holidaysStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Weekly Shifts Header
            Row(
              children: const [
                Icon(Icons.calendar_month, color: AppColors.primary, size: 20),
                SizedBox(width: 8),
                Text(
                  'Regular Weekly Shifts',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Weekly Schedules Card List
            schedulesAsync.when(
              data: (schedules) {
                return Column(
                  children: List.generate(7, (index) {
                    final dayNum = index + 1;
                    final dayName = _daysOfWeek[index];
                    final schedule = schedules.cast<WorkScheduleData?>().firstWhere(
                          (s) => s?.dayOfWeek == dayNum,
                          orElse: () => null,
                        );

                    final isWorkingDay = schedule != null;

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isWorkingDay ? AppColors.primaryLight : Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  dayName.substring(0, 1),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isWorkingDay ? AppColors.primary : AppColors.muted,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dayName,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isWorkingDay
                                        ? '${schedule.startTime} - ${schedule.endTime} (Break: ${schedule.breakStart ?? "-"} to ${schedule.breakEnd ?? "-"})'
                                        : 'Day Off / Weekend',
                                    style: TextStyle(
                                      color: isWorkingDay ? AppColors.text : AppColors.muted,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: isWorkingDay
                                    ? AppColors.success.withValues(alpha: 0.12)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isWorkingDay ? 'Working' : 'Off',
                                style: TextStyle(
                                  color: isWorkingDay ? AppColors.success : AppColors.muted,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error: $err'),
            ),
            const SizedBox(height: 20),

            // Company Holidays
            Row(
              children: const [
                Icon(Icons.beach_access, color: Colors.blueAccent, size: 20),
                SizedBox(width: 8),
                Text(
                  'Upcoming Holidays',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            holidaysAsync.when(
              data: (holidays) {
                if (holidays.isEmpty) {
                  return const Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No upcoming holidays recorded.', style: TextStyle(color: AppColors.muted)),
                    ),
                  );
                }

                return Column(
                  children: holidays.map((holiday) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.event, color: Colors.blueAccent, size: 20),
                        ),
                        title: Text(holiday.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                        subtitle: Text(
                          '${holiday.holidayDate} • ${holiday.description ?? "Public Holiday"}',
                          style: const TextStyle(color: AppColors.muted, fontSize: 12),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error: $err'),
            ),
          ],
        ),
      ),
    );
  }
}
