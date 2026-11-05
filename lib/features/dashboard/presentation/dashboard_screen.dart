import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/utils/attendance_calculator.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_status_badge.dart';
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            tooltip: 'View Profile',
            icon: const Icon(Icons.account_circle_outlined, size: 22),
            onPressed: () => context.push('/profile'),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          ref.invalidate(todayAttendanceProvider);
          ref.invalidate(todayScheduleProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Greeting & Profile Header
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.surfaceSecondary,
                          child: Text(
                            (employee?.name.isNotEmpty ?? false)
                                ? employee!.name.substring(0, 1).toUpperCase()
                                : 'E',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, ${employee?.name ?? 'Employee'}',
                                style: AppTypography.cardTitle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${employee?.employeeCode ?? 'EMP001'} • ${employee?.position ?? 'Staff'}',
                                style: AppTypography.supporting,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Live Clock Card (Neutral & Calm)
                  AppCard(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                      vertical: AppSpacing.lg,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('EEEE, dd MMMM yyyy').format(_currentTime),
                              style: AppTypography.supporting.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              DateFormat('HH:mm:ss').format(_currentTime),
                              style: AppTypography.importantNumber,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceSecondary,
                            borderRadius: AppRadius.borderRadiusLg,
                          ),
                          child: const Icon(
                            Icons.access_time_rounded,
                            color: AppColors.textSecondary,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Attendance Status Card
                  attendanceAsync.when(
                    data: (record) {
                      final isCheckedIn = record != null && record.checkIn != null;
                      final isCheckedOut = record != null && record.checkOut != null;

                      String statusLabel = 'Not Checked In';
                      if (isCheckedOut) {
                        statusLabel = 'Completed';
                      } else if (isCheckedIn) {
                        statusLabel = record.status == 'late' ? 'Late' : 'Working';
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

                      return AppCard(
                        padding: const EdgeInsets.all(AppSpacing.xl),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Today's Attendance",
                                  style: AppTypography.cardTitle,
                                ),
                                AppStatusBadge.fromStatus(statusLabel),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xl),
                            // Stat columns
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.md,
                                horizontal: AppSpacing.sm,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceSecondary,
                                borderRadius: AppRadius.borderRadiusLg,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildAttendanceStatItem(
                                      label: 'Check In',
                                      value: isCheckedIn
                                          ? AttendanceCalculator.formatTimeFromMillis(record.checkIn!)
                                          : '--:--',
                                      icon: Icons.login_rounded,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 36,
                                    color: AppColors.border,
                                  ),
                                  Expanded(
                                    child: _buildAttendanceStatItem(
                                      label: 'Check Out',
                                      value: isCheckedOut
                                          ? AttendanceCalculator.formatTimeFromMillis(record.checkOut!)
                                          : '--:--',
                                      icon: Icons.logout_rounded,
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 36,
                                    color: AppColors.border,
                                  ),
                                  Expanded(
                                    child: _buildAttendanceStatItem(
                                      label: 'Working Time',
                                      value: durationStr,
                                      icon: Icons.timer_outlined,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xl),

                            // Main attendance action button (Red primary accent)
                            FilledButton.icon(
                              onPressed: isCheckedOut
                                  ? null
                                  : () {
                                      final isOut = isCheckedIn;
                                      context.push('/attendance/scanner?type=${isOut ? 'checkout' : 'checkin'}');
                                    },
                              icon: Icon(
                                isCheckedOut
                                    ? Icons.check_circle_outline
                                    : (isCheckedIn ? Icons.logout_rounded : Icons.camera_alt_outlined),
                                size: 18,
                              ),
                              label: Text(
                                isCheckedOut
                                    ? 'Attendance Finished Today'
                                    : (isCheckedIn ? 'Check Out via Face Scanner' : 'Check In via Face Scanner'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xxxl),
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                      ),
                    ),
                    error: (err, _) => AppCard(
                      child: Text('Error loading attendance: $err', style: AppTypography.supporting),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // Today Schedule Summary Card
                  scheduleAsync.when(
                    data: (schedule) => AppCard(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                              SizedBox(width: AppSpacing.sm),
                              Text(
                                "Today's Work Schedule",
                                style: AppTypography.cardTitle,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          if (schedule != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Shift Hours', style: AppTypography.supporting),
                                Text(
                                  '${schedule.startTime} - ${schedule.endTime}',
                                  style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            if (schedule.breakStart != null) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Break Window', style: AppTypography.supporting),
                                  Text(
                                    '${schedule.breakStart} - ${schedule.breakEnd}',
                                    style: AppTypography.supporting.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ] else ...[
                            const Text(
                              'No regular shift scheduled for today (Weekend/Off day).',
                              style: TextStyle(color: AppColors.textMuted, fontStyle: FontStyle.italic, fontSize: 13),
                            ),
                          ],
                        ],
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
      ),
    );
  }

  Widget _buildAttendanceStatItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 18),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: AppTypography.cardTitle.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.caption,
        ),
      ],
    );
  }
}
