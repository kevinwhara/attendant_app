import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/attendance_calculator.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_empty_state.dart';
import '../../../shared/widgets/app_status_badge.dart';
import 'history_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(attendanceHistoryStreamProvider);
    final filter = ref.watch(historyFilterProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            children: [
              // Filter Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                color: AppColors.surface,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2030),
                          );
                          if (picked != null) {
                            final formatted = DateFormat('yyyy-MM-dd').format(picked);
                            ref.read(historyFilterProvider.notifier).setFilter(
                                  filter.copyWith(date: () => formatted),
                                );
                          }
                        },
                        icon: const Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                        label: Text(
                          filter.date != null ? 'Date: ${filter.date}' : 'Filter by Date',
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.button.copyWith(color: AppColors.textPrimary),
                        ),
                      ),
                    ),
                    if (filter.date != null || filter.month != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      IconButton(
                        tooltip: 'Clear filter',
                        icon: const Icon(Icons.clear_rounded, size: 20, color: AppColors.textSecondary),
                        onPressed: () {
                          ref.read(historyFilterProvider.notifier).clear();
                        },
                      ),
                    ],
                  ],
                ),
              ),
              const Divider(height: 1),

              // Attendance Records List
              Expanded(
                child: historyAsync.when(
                  data: (records) {
                    if (records.isEmpty) {
                      return const AppEmptyState(
                        icon: Icons.history_toggle_off_outlined,
                        title: 'No attendance records found.',
                        subtitle: 'Your completed check-ins and check-outs will show here.',
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      itemCount: records.length,
                      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final item = records[index];
                        return _buildHistoryCard(context, item);
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                  ),
                  error: (err, _) => Center(
                    child: Text('Error loading history: $err', style: AppTypography.supporting),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, AttendanceRecord record) {
    String durationText = '--';
    if (record.checkIn != null) {
      final inTime = DateTime.fromMillisecondsSinceEpoch(record.checkIn!, isUtc: true);
      final outTime = record.checkOut != null
          ? DateTime.fromMillisecondsSinceEpoch(record.checkOut!, isUtc: true)
          : null;
      final dur = AttendanceCalculator.calculateWorkingDuration(
        checkIn: inTime,
        checkOut: outTime,
        breakStartStr: '12:00',
        breakEndStr: '13:00',
      );
      durationText = AttendanceCalculator.formatDuration(dur);
    }

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      onTap: () => _showRecordDetail(context, record, durationText),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    record.attendanceDate,
                    style: AppTypography.cardTitle.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              AppStatusBadge.fromStatus(record.status),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surfaceSecondary,
              borderRadius: AppRadius.borderRadiusMd,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTimeColumn(
                    'Check In',
                    record.checkIn != null
                        ? AttendanceCalculator.formatTimeFromMillis(record.checkIn!)
                        : '--:--',
                    Icons.login_rounded,
                  ),
                ),
                Expanded(
                  child: _buildTimeColumn(
                    'Check Out',
                    record.checkOut != null
                        ? AttendanceCalculator.formatTimeFromMillis(record.checkOut!)
                        : '--:--',
                    Icons.logout_rounded,
                  ),
                ),
                Expanded(
                  child: _buildTimeColumn(
                    'Working Time',
                    durationText,
                    Icons.timer_outlined,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 13, color: AppColors.textSecondary),
            const SizedBox(width: AppSpacing.xs),
            Text(label, style: AppTypography.caption),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void _showRecordDetail(BuildContext context, AttendanceRecord record, String duration) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Attendance Detail — ${record.attendanceDate}',
                      style: AppTypography.sectionTitle,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.verified_outlined, color: AppColors.success),
                  title: const Text('Face Detection Check', style: AppTypography.cardTitle),
                  subtitle: Text(
                    'Check-in: ${record.checkInFaceDetected == 1 ? "VERIFIED" : "NONE"} | Check-out: ${record.checkOutFaceDetected == 1 ? "VERIFIED" : "NONE"}',
                    style: AppTypography.supporting,
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.timelapse_outlined, color: AppColors.info),
                  title: const Text('Effective Working Duration', style: AppTypography.cardTitle),
                  subtitle: Text(
                    '$duration (Standard 1h lunch break deducted)',
                    style: AppTypography.supporting,
                  ),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.info_outline, color: AppColors.textSecondary),
                  title: const Text('Status', style: AppTypography.cardTitle),
                  subtitle: Text(record.status.toUpperCase(), style: AppTypography.supporting),
                ),
                const SizedBox(height: AppSpacing.xl),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
