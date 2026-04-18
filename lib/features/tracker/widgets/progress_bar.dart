import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: AppColors.textPrimary)),
              Text('$percentage%', style: const TextStyle(color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.trackerBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                if (percentage > 0)
                  Expanded(
                    flex: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                if (percentage < 100)
                  Expanded(
                    flex: 100 - percentage,
                    child: const SizedBox(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
