import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/utils/attendance_calculator.dart';
import '../../auth/presentation/auth_providers.dart';
import '../../attendance/presentation/attendance_providers.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late Timer _clockTimer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _currentTime = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employee = ref.watch(currentEmployeeProvider);
    final attendanceAsync = ref.watch(todayAttendanceProvider);
    final scheduleAsync = ref.watch(todayScheduleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.text,
        actions: [
          IconButton(
            tooltip: 'View Profile',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(todayAttendanceProvider);
          ref.invalidate(todayScheduleProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Greeting & Profile Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.primaryLight,
                          child: Text(
                            (employee?.name.isNotEmpty ?? false)
                                ? employee!.name.substring(0, 1).toUpperCase()
                                : 'E',
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, ${employee?.name ?? 'Employee'}',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${employee?.employeeCode ?? 'EMP001'} • ${employee?.position ?? 'Staff'}',
                                style: const TextStyle(color: AppColors.muted, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Live Clock Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEEE, dd MMMM yyyy').format(_currentTime),
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('HH:mm:ss').format(_currentTime),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.access_time_filled,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Attendance Status Card
                attendanceAsync.when(
                  data: (record) {
                    final isCheckedIn = record != null && record.checkIn != null;
                    final isCheckedOut = record != null && record.checkOut != null;

                    Color statusColor = AppColors.muted;
                    String statusLabel = 'Not Checked In';
                    if (isCheckedOut) {
                      statusColor = AppColors.success;
                      statusLabel = 'Completed';
                    } else if (isCheckedIn) {
                      if (record.status == 'late') {
                        statusColor = AppColors.lateBadge;
                        statusLabel = 'Late';
                      } else {
                        statusColor = AppColors.warning;
                        statusLabel = 'Working';
                      }
                    }

                    // Calculate working duration
                    String durationStr = '--';
                    if (isCheckedIn) {
                      final inTime = DateTime.fromMillisecondsSinceEpoch(record.checkIn!, isUtc: true);
                      final outTime = isCheckedOut
                          ? DateTime.fromMillisecondsSinceEpoch(record.checkOut!, isUtc: true)
                          : _currentTime;
                      final dur = AttendanceCalculator.calculateWorkingDuration(
                        checkIn: inTime,
                        checkOut: outTime,
                        breakStartStr: '12:00',
                        breakEndStr: '13:00',
                      );
                      durationStr = AttendanceCalculator.formatDuration(dur);
                    }

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Today's Attendance",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    statusLabel,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildAttendanceStatItem(
                                    label: 'Check In',
                                    value: isCheckedIn
                                        ? AttendanceCalculator.formatTimeFromMillis(record.checkIn!)
                                        : '--:--',
                                    icon: Icons.login_rounded,
                                    iconColor: AppColors.success,
                                  ),
                                ),
                                Expanded(
                                  child: _buildAttendanceStatItem(
                                    label: 'Check Out',
                                    value: isCheckedOut
                                        ? AttendanceCalculator.formatTimeFromMillis(record.checkOut!)
                                        : '--:--',
                                    icon: Icons.logout_rounded,
                                    iconColor: AppColors.primary,
                                  ),
                                ),
                                Expanded(
                                  child: _buildAttendanceStatItem(
                                    label: 'Working Time',
                                    value: durationStr,
                                    icon: Icons.timer_outlined,
                                    iconColor: Colors.blueAccent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Action Button
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: isCheckedOut
                                    ? null
                                    : () {
                                        final isOut = isCheckedIn;
                                        context.push('/attendance/scanner?type=${isOut ? 'checkout' : 'checkin'}');
                                      },
                                style: FilledButton.styleFrom(
                                  backgroundColor: isCheckedIn ? AppColors.primaryDark : AppColors.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                icon: Icon(
                                  isCheckedOut
                                      ? Icons.check_circle_outline
                                      : (isCheckedIn ? Icons.logout : Icons.camera_alt_outlined),
                                ),
                                label: Text(
                                  isCheckedOut
                                      ? 'Attendance Finished Today'
                                      : (isCheckedIn ? 'Check Out via Face Scanner' : 'Check In via Face Scanner'),
                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  loading: () => const Center(child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  )),
                  error: (err, _) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Error loading attendance: $err'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Today Schedule Summary
                scheduleAsync.when(
                  data: (schedule) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.primary),
                              SizedBox(width: 8),
                              Text(
                                "Today's Work Schedule",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          if (schedule != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Shift Hours', style: TextStyle(color: AppColors.muted)),
                                Text(
                                  '${schedule.startTime} - ${schedule.endTime}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            if (schedule.breakStart != null) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Break Window', style: TextStyle(color: AppColors.muted)),
                                  Text(
                                    '${schedule.breakStart} - ${schedule.breakEnd}',
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ] else ...[
                            const Text(
                              'No regular shift scheduled for today (Weekend/Off day).',
                              style: TextStyle(color: AppColors.muted, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceStatItem({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.muted),
        ),
      ],
    );
  }
}
