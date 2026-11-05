import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/database/app_database.dart';
import '../../../core/utils/attendance_calculator.dart';
import 'history_providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(attendanceHistoryStreamProvider);
    final filter = ref.watch(historyFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
      ),
      body: Column(
        children: [
          // Filter Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
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
                    icon: const Icon(Icons.filter_alt_outlined, size: 18),
                    label: Text(
                      filter.date != null ? 'Date: ${filter.date}' : 'Filter by Date',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                if (filter.date != null || filter.month != null) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: 'Clear filter',
                    icon: const Icon(Icons.clear, color: AppColors.primary),
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
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history_toggle_off, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          const Text(
                            'No attendance records found.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.muted,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Your completed check-ins and check-outs will show here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.muted, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: records.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = records[index];
                    return _buildHistoryCard(context, item);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error loading history: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, AttendanceRecord record) {
    Color badgeColor = AppColors.muted;
    String badgeText = record.status.toUpperCase();

    if (record.status == 'completed') {
      badgeColor = AppColors.success;
      badgeText = 'COMPLETED';
    } else if (record.status == 'late') {
      badgeColor = AppColors.lateBadge;
      badgeText = 'LATE';
    } else if (record.status == 'working') {
      badgeColor = AppColors.warning;
      badgeText = 'WORKING';
    }

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

    return Card(
      child: InkWell(
        onTap: () => _showRecordDetail(context, record, durationText),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_month_outlined, size: 18, color: AppColors.muted),
                      const SizedBox(width: 6),
                      Text(
                        record.attendanceDate,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        color: badgeColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildTimeColumn(
                      'Check In',
                      record.checkIn != null
                          ? AttendanceCalculator.formatTimeFromMillis(record.checkIn!)
                          : '--:--',
                      Icons.login_rounded,
                      AppColors.success,
                    ),
                  ),
                  Expanded(
                    child: _buildTimeColumn(
                      'Check Out',
                      record.checkOut != null
                          ? AttendanceCalculator.formatTimeFromMillis(record.checkOut!)
                          : '--:--',
                      Icons.logout_rounded,
                      AppColors.primary,
                    ),
                  ),
                  Expanded(
                    child: _buildTimeColumn(
                      'Working Time',
                      durationText,
                      Icons.timer_outlined,
                      Colors.blueAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String label, String value, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  void _showRecordDetail(BuildContext context, AttendanceRecord record, String duration) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Attendance Detail — ${record.attendanceDate}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.verified, color: AppColors.success),
                title: const Text('Face Detection Check'),
                subtitle: Text(
                  'Check-in: ${record.checkInFaceDetected == 1 ? "VERIFIED" : "NONE"} | Check-out: ${record.checkOutFaceDetected == 1 ? "VERIFIED" : "NONE"}',
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.timelapse, color: Colors.blue),
                title: const Text('Effective Working Duration'),
                subtitle: Text('$duration (Standard 1h lunch break deducted)'),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.info_outline, color: AppColors.muted),
                title: const Text('Status'),
                subtitle: Text(record.status.toUpperCase()),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
