import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';

class ConfirmationScreen extends StatelessWidget {
  final String actionType; // 'checkin' or 'checkout'

  const ConfirmationScreen({
    super.key,
    required this.actionType,
  });

  @override
  Widget build(BuildContext context) {
    final isCheckIn = actionType == 'checkin';
    final title = isCheckIn ? 'Check-in Recorded' : 'Check-out Recorded';
    final now = DateTime.now();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xxl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Semantic Success Badge
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: AppColors.successBackground,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: AppColors.success,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTypography.pageTitle,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  const Text(
                    'Face verified successfully. Your attendance record has been securely saved to the database.',
                    textAlign: TextAlign.center,
                    style: AppTypography.supporting,
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Record Summary Card
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Date', style: AppTypography.supporting),
                            Text(
                              DateFormat('EEEE, dd MMM yyyy').format(now),
                              style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Divider(height: AppSpacing.xxl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Timestamp', style: AppTypography.supporting),
                            Text(
                              DateFormat('HH:mm:ss').format(now),
                              style: AppTypography.body.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: AppSpacing.xxl),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Face Verification', style: AppTypography.supporting),
                            Row(
                              children: const [
                                Icon(Icons.verified_outlined, size: 14, color: AppColors.success),
                                SizedBox(width: AppSpacing.xs),
                                Text(
                                  'PASSED (On-Device)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Actions
                  FilledButton(
                    onPressed: () => context.go('/home'),
                    child: const Text('Return to Dashboard'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  OutlinedButton(
                    onPressed: () => context.go('/history'),
                    child: const Text('View Attendance History'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
