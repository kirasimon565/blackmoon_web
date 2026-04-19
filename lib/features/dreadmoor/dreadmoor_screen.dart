import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class DreadmoorScreen extends StatelessWidget {
  const DreadmoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        final content = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('DREADMOOR', style: AppTextStyles.h1),
            const SizedBox(height: 16),
            const Text(
              'A story told through conversations',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                const ElevatedButton(
                  onPressed: null,
                  child: Text('Play'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () => context.go('/tracker'),
                  child: const Text('Episode Tracker'),
                ),
              ],
            ),
          ],
        );

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/backgrounds/dreadmoor_forest.png',
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(
                color: AppColors.background.withAlpha(200),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: isMobile
                      ? content
                      : Row(
                          children: [
                            Expanded(child: content),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
