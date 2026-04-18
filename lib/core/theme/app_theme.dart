import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: AppTextStyles.fontFamily,
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.h1,
        displayMedium: AppTextStyles.h2,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.bodySecondary,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        surface: AppColors.backgroundSecondary,
        onPrimary: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              // Slightly darker accent color for hover state
              return const Color(0xFF2A6082); // Darkened from AppColors.accent (0xFF3A7CA5)
            }
            return AppColors.accent;
          }),
          foregroundColor: WidgetStateProperty.all(AppColors.textPrimary),
          textStyle: WidgetStateProperty.all(AppTextStyles.bodyMedium),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 36, vertical: 18)),
          elevation: WidgetStateProperty.all(6), // Slightly softer shadow by increasing elevation
          shadowColor: WidgetStateProperty.all(Colors.black.withAlpha(100)), // Stronger soft shadow
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.backgroundSecondary; // Slightly lighter than background for hover
            }
            return AppColors.background;
          }),
          foregroundColor: WidgetStateProperty.all(AppColors.textPrimary),
          textStyle: WidgetStateProperty.all(AppTextStyles.bodyMedium),
          side: WidgetStateProperty.all(const BorderSide(color: AppColors.accent, width: 2)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 36, vertical: 18)),
          elevation: WidgetStateProperty.all(6),
          shadowColor: WidgetStateProperty.all(Colors.black.withAlpha(100)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
