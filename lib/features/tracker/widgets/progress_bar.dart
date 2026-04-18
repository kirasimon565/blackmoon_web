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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textPrimary)),
            Text('$percentage%', style: const TextStyle(color: AppColors.textSecondary)),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF1A222C),
            borderRadius: BorderRadius.circular(8),
          ),
            child: Row(
              children: [
                if (percentage > 0)
                  Expanded(
                    flex: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A7CA5),
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
    );
  }
}
