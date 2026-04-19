import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ProgressBar extends StatelessWidget {
  final String label;
  final int percentage;

  const ProgressBar({
    super.key,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: 12, // Reduced
            letterSpacing: 1.5,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 32, // Full bar height
          child: Stack(
            children: [
              // Background bar
              Container(
                width: double.infinity,
                color: AppColors.backgroundSecondary, // dark background
              ),
              // Progress fill
              FractionallySizedBox(
                widthFactor: percentage / 100.0,
                child: Container(
                  color: AppColors.accent, // Accent color fill
                ),
              ),
              // Percentage text aligned right inside the bar
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    '$percentage%',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
