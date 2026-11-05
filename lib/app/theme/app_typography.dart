import 'package:flutter/material.dart';
import 'app_colors.dart';

abstract final class AppTypography {
  static const headingLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );

  static const headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static const title = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.text,
  );

  static const subtitle = TextStyle(
    fontSize: 13,
    color: AppColors.muted,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.muted,
  );
}
