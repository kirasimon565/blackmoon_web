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
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: AppColors.textPrimary,
          textStyle: AppTextStyles.bodyMedium,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          elevation: 4, // Enables shadow
          shadowColor: Colors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          textStyle: AppTextStyles.bodyMedium,
          side: const BorderSide(color: AppColors.accent, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          elevation: 4, // Enables shadow
          shadowColor: Colors.black.withOpacity(0.25),
          backgroundColor: AppColors.background, // Ensure background is solid for shadow to show properly
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
