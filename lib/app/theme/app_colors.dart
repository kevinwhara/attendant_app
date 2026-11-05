import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary (Brand Accent)
  static const primary = Color(0xFFE53935);
  static const primaryDark = Color(0xFFC62828);
  static const primaryLight = Color(0xFFFFEBEE);

  // Neutral Colors (Primary Visual Foundation)
  static const background = Color(0xFFF8F9FA);
  static const surface = Color(0xFFFFFFFF);
  static const surfaceSecondary = Color(0xFFF1F3F5);
  static const textPrimary = Color(0xFF212121);
  static const textSecondary = Color(0xFF757575);
  static const textMuted = Color(0xFF9E9E9E);
  static const border = Color(0xFFEAECEF);
  static const disabled = Color(0xFFBDBDBD);

  // Backward-compatibility aliases
  static const text = textPrimary;
  static const muted = textSecondary;

  // Semantic Colors
  static const success = Color(0xFF2E7D32);
  static const successBackground = Color(0xFFE8F5E9);
  static const warning = Color(0xFFF9A825);
  static const warningBackground = Color(0xFFFFF8E1);
  static const error = Color(0xFFD32F2F);
  static const errorBackground = Color(0xFFFFEBEE);
  static const info = Color(0xFF1976D2);
  static const infoBackground = Color(0xFFE3F2FD);
  static const lateBadge = Color(0xFFF57C00);
}
