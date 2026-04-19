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
          height: 4, // Extremely thin bar
          child: Stack(
            children: [
              // Background bar
              Container(
                width: double.infinity,
                color: Colors.white.withAlpha(20),
              ),
              // Progress fill
              FractionallySizedBox(
                widthFactor: percentage / 100.0,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
