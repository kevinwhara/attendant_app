import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/database/app_database.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_section_header.dart';
import '../../../shared/widgets/app_status_badge.dart';
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
    final currentDayOfWeek = DateTime.now().weekday; // 1 = Monday, 7 = Sunday

  return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Work Schedule'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Section: Regular Weekly Shifts
                const AppSectionHeader(
                  title: 'Regular Weekly Shifts',
                  icon: Icons.calendar_month_outlined,
                ),
                const SizedBox(height: AppSpacing.md),

                // Weekly Schedules List
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
                        final isToday = dayNum == currentDayOfWeek;

                        return Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: AppCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.md,
                            ),
                            border: isToday
                                ? Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 1.5)
                                : null,
                            child: Row(
                              children: [
                                // Day Avatar Indicator
                                Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: isToday
                                        ? AppColors.primaryLight
                                        : AppColors.surfaceSecondary,
                                    borderRadius: AppRadius.borderRadiusMd,
                                  ),
                                  child: Center(
                                    child: Text(
                                      dayName.substring(0, 3).toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: isToday
                                            ? AppColors.primary
                                            : AppColors.textSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.lg),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            dayName,
                                            style: AppTypography.cardTitle.copyWith(
                                              fontWeight: isToday ? FontWeight.w600 : FontWeight.w500,
                                            ),
                                          ),
                                          if (isToday) ...[
                                            const SizedBox(width: AppSpacing.sm),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryLight,
                                                borderRadius: AppRadius.borderRadiusSm,
                                              ),
                                              child: const Text(
                                                'TODAY',
                                                style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        isWorkingDay
                                            ? '${schedule.startTime} - ${schedule.endTime} (Break: ${schedule.breakStart ?? "-"} to ${schedule.breakEnd ?? "-"})'
                                            : 'Day Off / Weekend',
                                        style: AppTypography.supporting,
                                      ),
                                    ],
                                  ),
                                ),
                                AppStatusBadge.fromStatus(isWorkingDay ? 'working' : 'off'),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.xxxl),
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                    ),
                  ),
                  error: (err, _) => Text('Error: $err', style: AppTypography.supporting),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Section: Upcoming Holidays
                const AppSectionHeader(
                  title: 'Upcoming Holidays',
                  icon: Icons.event_outlined,
                ),
                const SizedBox(height: AppSpacing.md),

                holidaysAsync.when(
                  data: (holidays) {
                    if (holidays.isEmpty) {
                      return const AppCard(
                        child: Text('No upcoming holidays recorded.', style: AppTypography.supporting),
                      );
                    }

                    return Column(
                      children: holidays.map((holiday) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: AppCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.md,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: AppColors.infoBackground,
                                    borderRadius: AppRadius.borderRadiusMd,
                                  ),
                                  child: const Icon(Icons.event, color: AppColors.info, size: 18),
                                ),
                                const SizedBox(width: AppSpacing.lg),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        holiday.name,
                                        style: AppTypography.cardTitle,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${holiday.holidayDate} • ${holiday.description ?? "Public Holiday"}',
                                        style: AppTypography.supporting,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                  ),
                  error: (err, _) => Text('Error: $err', style: AppTypography.supporting),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
