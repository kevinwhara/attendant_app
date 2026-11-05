import 'package:flutter/material.dart';

abstract final class AppColors {
  static const primary = Color(0xffe53935),
      primaryDark = Color(0xffc62828),
      primaryLight = Color(0xffffebee),
      background = Color(0xfffafafa),
      text = Color(0xff212121),
      muted = Color(0xff757575),
      border = Color(0xffeeeeee),
      success = Color(0xff2e7d32),
      warning = Color(0xfff9a825);
}

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ).copyWith(primary: AppColors.primary, surface: Colors.white),
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Inter',
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: AppColors.border),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
  );
}
