import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';
import 'progress_bar.dart';

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
      // زيادة المسافة السفلية ليعطي شعوراً بالاتساع (Minimalism)
      padding: const EdgeInsets.only(bottom: 80, left: 8, right: 8), 
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500), // عرض أقل ليكون أكثر أناقة
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:,
        ),
      ),
    );
  }

  // دالة مخصصة لبناء الأشرطة بستايل Moonvale النحيف
  Widget _buildEverbyteTrack(String label, int percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:,
        ),
        const SizedBox(height: 10),
        // شريط التقدم النحيف جداً
        Stack(
          children: [
            // الخلفية (المسار الباهت)
            Container(
              height: 2, // نحيف جداً مثل الخيط
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // الجزء الملون (التقدم الحقيقي)
            AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              height: 2,
              width: (percentage / 100) * 500, // يتناسب مع العرض الأقصى
              decoration: BoxDecoration(
                color: const Color(0xFF50B5D8), // لون أزرق Moonvale الشهير
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF50B5D8).withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 1, // تأثير وهج بسيط (Glow)
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
