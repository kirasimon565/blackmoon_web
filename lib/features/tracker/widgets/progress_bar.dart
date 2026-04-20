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
          height: 40, // Full bar height
          child: Stack(
            children: [
              // Background bar
              Container(
                width: double.infinity,
                color: const Color(0xFF111418), // dark track
              ),
              // Progress fill
              FractionallySizedBox(
                widthFactor: percentage / 100.0,
                child: Container(
                  color: const Color(0xFF5C8FAF), // richer blue fill
                ),
              ),
              // Percentage text aligned right inside the bar
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text(
                    '$percentage%',
                    style: TextStyle(
                      color: Colors.white.withAlpha(200), // slightly dimmed white
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
