import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class HomeScreenNew extends StatelessWidget {
  const HomeScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine screen height minus header for layout purposes, ensuring it spans full height
    // Scaffold's Expanded takes care of available space, but we want the stack to fill it
    return Stack(
      children: [
        // Background Base Color
        Positioned.fill(
          child: Container(
            color: AppColors.background,
          ),
        ),

        // Fog Background Image
        Positioned.fill(
          child: Image.asset(
            'assets/images/backgrounds/fog_main.png',
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
                  AppColors.background.withAlpha(200),
                  AppColors.background.withAlpha(50),
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
                            'BLACKMOON',
                            style: AppTextStyles.h1,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Interactive story studio',
                            style: AppTextStyles.subtitle,
                          ),
                          const SizedBox(height: 48),
                          ElevatedButton(
                            onPressed: () {
                              // Enter action
                            },
                            child: const Text('Enter'),
                          ),
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
