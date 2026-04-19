import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class DreadmoorScreen extends StatelessWidget {
  const DreadmoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Base Color
        Positioned.fill(
          child: Container(
            color: AppColors.background,
          ),
        ),

        // Dreadmoor Forest Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/backgrounds/dreadmoor_forest.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
          ),
        ),

        // Noise Texture
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              repeat: ImageRepeat.repeat,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
              },
            ),
          ),
        ),

        // Dark Overlay Gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.background.withAlpha(220),
                  AppColors.background.withAlpha(80),
                ],
              ),
            ),
          ),
        ),

        // Main Content Constraints
        Positioned.fill(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Row(
                  children: [
                    // Left-aligned content
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DREADMOOR',
                            style: AppTextStyles.h1,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'A story told through conversations',
                            style: AppTextStyles.subtitle,
                          ),
                          const SizedBox(height: 48),
                          Row(
                            children: [
                              const ElevatedButton(
                                onPressed: null, // Do nothing for now
                                child: Text('Play'),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: () {
                                  context.go('/tracker');
                                },
                                child: const Text('Episode Tracker'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    // Right side = empty atmospheric space
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
