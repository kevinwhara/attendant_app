import 'package:flutter/material.dart';
import '../../app/theme/app_theme.dart';

class AppStatusBadge extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final IconData? icon;

  const AppStatusBadge({
    super.key,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    this.icon,
  });

  factory AppStatusBadge.fromStatus(String status, {bool uppercase = true}) {
    final lower = status.toLowerCase();
    switch (lower) {
      case 'completed':
        return AppStatusBadge(
          label: uppercase ? 'COMPLETED' : 'Completed',
          textColor: AppColors.success,
          backgroundColor: AppColors.successBackground,
          icon: Icons.check_circle_outline,
        );
      case 'working':
        return AppStatusBadge(
          label: uppercase ? 'WORKING' : 'Working',
          textColor: AppColors.info,
          backgroundColor: AppColors.infoBackground,
          icon: Icons.timer_outlined,
        );
      case 'late':
        return AppStatusBadge(
          label: uppercase ? 'LATE' : 'Late',
          textColor: AppColors.warning,
          backgroundColor: AppColors.warningBackground,
          icon: Icons.warning_amber_rounded,
        );
      case 'off':
      case 'weekend':
        return AppStatusBadge(
          label: uppercase ? 'OFF' : 'Off',
          textColor: AppColors.textSecondary,
          backgroundColor: AppColors.surfaceSecondary,
        );
      case 'not checked in':
      default:
        return AppStatusBadge(
          label: uppercase ? 'NOT CHECKED IN' : 'Not Checked In',
          textColor: AppColors.textSecondary,
          backgroundColor: AppColors.surfaceSecondary,
          icon: Icons.radio_button_unchecked,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.borderRadiusSm,
        border: Border.all(color: textColor.withValues(alpha: 0.15), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 11,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
