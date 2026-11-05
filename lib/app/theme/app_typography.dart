import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTypography {
  // Page Title: 24px, Semibold
  static const pageTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  // Section Title: 18px, Semibold
  static const sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // Card Title: 15-16px, Medium
  static const cardTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Body: 14px, Regular
  static const body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // Supporting / Secondary Text: 12-13px, Regular
  static const supporting = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  // Caption: 12px, Regular
  static const caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  // Button: 14-15px, Medium
  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  // Important Number: 26-32px, Semibold
  static const importantNumber = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  // Backward compatibility aliases
  static const headingLarge = pageTitle;
  static const headingMedium = sectionTitle;
  static const title = cardTitle;
  static const subtitle = supporting;
}
