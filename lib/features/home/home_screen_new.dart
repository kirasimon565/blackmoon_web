import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreenNew extends StatelessWidget {
  const HomeScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        final content = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('BLACKMOON', style: AppTextStyles.h1),
            const SizedBox(height: 16),
            const Text(
              'Interactive story studio',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => context.go('/dreadmoor'),
              child: const Text('Enter'),
            ),
          ],
        );

        return Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/backgrounds/fog_main.png',
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(
                color: AppColors.background.withAlpha(180),
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
