import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/responsive.dart';
import '../../../routing/routes.dart';
import '../../../shared/layout/responsive_container.dart';
import '../home/widgets/concave_header.dart'; // Reuse the concave header

class DreadmoorPage extends StatelessWidget {
  const DreadmoorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _DreadmoorHeader(),
        SizedBox(height: 64),
        _GameDescription(),
        SizedBox(height: 64),
      ],
    );
  }
}

class _DreadmoorHeader extends StatelessWidget {
  const _DreadmoorHeader();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = Responsive.isMobile(context) ? screenHeight * 0.6 : screenHeight * 0.7;

    return ConcaveHeader(
      height: headerHeight,
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        image: const DecorationImage(
          image: AssetImage('assets/images/backgrounds/dreadmoor_forest.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black54, // Darken the image
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: ResponsiveContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'DREADMOOR',
                style: AppTextStyles.h1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'A story told through conversations',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {}, // "Coming Soon" or play action
                    child: const Text('Coming Soon'),
                  ),
                  OutlinedButton(
                    onPressed: () => context.go(AppRoutes.tracker),
                    child: const Text('Episode Tracker →'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GameDescription extends StatelessWidget {
  const _GameDescription();

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: const Text(
        'Follow conversations, uncover clues, and shape the outcome.',
        style: AppTextStyles.body,
        textAlign: TextAlign.center,
      ),
    );
  }
}
