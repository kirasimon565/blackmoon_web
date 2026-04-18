import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../routing/routes.dart';
import '../../../shared/layout/responsive_container.dart';
import 'widgets/concave_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _IntroSection(),
        SizedBox(height: 48),
        _FeaturedProjectSection(),
        SizedBox(height: 48),
        _AboutSection(),
        SizedBox(height: 48),
      ],
    );
  }
}

class _IntroSection extends StatelessWidget {
  const _IntroSection();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = Responsive.isMobile(context) ? screenHeight * 0.6 : screenHeight * 0.7;

    return ConcaveHeader(
      height: headerHeight,
      child: Stack(
        children: [
          // Background Layer 1: fog
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/fog_main.png',
              fit: BoxFit.cover,
              color: Colors.white.withAlpha(76), // 0.3 opacity
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          // Background Layer 2: noise texture
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              color: Colors.white.withAlpha(38), // ~0.15 opacity
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          // Content
          Center(
            child: ResponsiveContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'BLACKMOON',
                    style: AppTextStyles.h1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Interactive story studio',
                    style: AppTextStyles.h2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(76), // 0.3 opacity
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => context.go(AppRoutes.dreadmoor),
                      child: const Text('View Projects'),
                    ),
                  ),
                  const SizedBox(height: 48),
                  Text(
                    'Independent studio focused on narrative-driven experiences.',
                    style: AppTextStyles.bodySecondary,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedProjectSection extends StatelessWidget {
  const _FeaturedProjectSection();

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('DREADMOOR', style: AppTextStyles.h2),
          const SizedBox(height: 16),
          const Text(
            'A narrative-driven crime experience told through messages.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.dreadmoor),
                child: const Text('View Game →'),
              ),
              OutlinedButton(
                onPressed: () => context.go(AppRoutes.tracker),
                child: const Text('Episode Tracker →'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        width: double.infinity,
        child: const Text(
          'BLACKMOON is an independent studio focused on interactive storytelling.',
          style: AppTextStyles.body,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
