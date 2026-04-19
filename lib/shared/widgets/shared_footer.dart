import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

class SharedFooter extends StatelessWidget {
  const SharedFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minimal placeholder for social icons
                _socialIcon(Icons.link),
                const SizedBox(width: 16),
                _socialIcon(Icons.share),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              children: const [
                Text('Terms', style: AppTextStyles.bodySecondary),
                Text('Privacy', style: AppTextStyles.bodySecondary),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '© BLACKMOON Studio',
              style: AppTextStyles.bodySecondary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF11161D), // AppColors.backgroundSecondary
      ),
      child: Icon(
        icon,
        color: const Color(0xFF9AA4AF), // AppColors.textSecondary
        size: 20,
      ),
    );
  }
}
