import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProgressBar extends StatelessWidget {
  final String label;
  final int percentage;

  const ProgressBar({super.key, required this.label, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 10), // مسافة بين النص والشريط
        // الشريط النحيف جداً (الستايل الرسمي لـ Moonvale)
        SizedBox(
          height: 2, // نحيف جداً ليعطي مظهراً عصرياً
          child: Stack(
            children: [
              // خلفية الشريط (المسار)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(26), // 0.1 opacity
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // الجزء الملون (التقدم) مع تأثير التوهج (Glow)
              FractionallySizedBox(
                widthFactor: percentage / 100.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF50B5D8), // لون أزرق Moonvale
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF50B5D8,
                        ).withAlpha(128), // 0.5 opacity
                        blurRadius: 10, // تأثير الوهج
                        spreadRadius: 1,
                      ),
                    ],
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
