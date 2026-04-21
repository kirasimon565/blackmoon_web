import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';

class EpisodeCardWithRebecca extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeCardWithRebecca({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 80, left: 24, right: 24), 
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:,
        ),
      ),
    );
  }

  // دالة بناء الأشرطة النحيفة والفسفورية (المصححة)
  Widget _buildEverbyteTrack(String label, int percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:,
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            // خلفية الشريط الباهتة
            Container(
              height: 2, 
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // الجزء الملون (التقدم) مع تأثير التوهج
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              height: 2,
              width: (percentage / 100) * 450, // تم ضبط الحساب ليتناسب مع الحاوية
              decoration: BoxDecoration(
                color: const Color(0xFF50B5D8), 
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF50B5D8).withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 1, 
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
