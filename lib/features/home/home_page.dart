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
        SizedBox(height: 56),
        _FeaturedProjectSection(),
        SizedBox(height: 56),
        _AboutSection(),
        SizedBox(height: 56),
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
          Positioned.fill(
            child: Container(color: const Color(0xFF0B0F14)),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/fog_main.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                'assets/images/backgrounds/noise_texture.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.75),
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.85),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
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
                  const SizedBox(height: 12),
                  Text(
                    'Interactive story studio',
                    style: AppTextStyles.subtitle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.go(AppRoutes.dreadmoor),
                    child: const Text('View Projects'),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Independent studio focused on narrative-driven experiences.',
                    style: AppTextStyles.bodySecondary.copyWith(color: const Color(0xFF9AA4AF).withAlpha(178)),
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
          const SizedBox(height: 20),
          const Text(
            'A narrative-driven crime experience told through messages.',
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
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
