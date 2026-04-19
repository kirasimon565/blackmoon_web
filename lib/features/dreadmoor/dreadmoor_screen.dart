import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/shared_sliver_app_bar.dart';
import '../../shared/widgets/shared_footer.dart';

class DreadmoorScreen extends StatelessWidget {
  const DreadmoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // L0: Global Background
          Positioned.fill(
            child: Container(
              color: AppColors.background,
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.05),
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),

          // L1: CustomScrollView
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // SliverAppBar
              const SharedSliverAppBar(),

              // Hero Section
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // L0: Hero Background Image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/backgrounds/dreadmoor_forest.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      // L1: Dark Overlay Gradient
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.black.withAlpha(200),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // L2: Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "CURRENT PROJECT",
                              style: AppTextStyles.bodySecondary.copyWith(
                                fontSize: 12,
                                letterSpacing: 2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'DREADMOOR',
                              style: AppTextStyles.h1,
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: 40,
                              height: 2,
                              color: AppColors.accent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Content Section (Left aligned)
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'A story told through conversations',
                        style: AppTextStyles.h2,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Uncover the secrets of the dark forest in this interactive narrative.',
                        style: AppTextStyles.bodySecondary.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              // Items Section (Buttons/Actions)
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      const ElevatedButton(
                        onPressed: null, // Placeholder for "Play"
                        child: Text('Play Now'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () => context.go('/tracker'),
                        child: const Text('Episode Tracker'),
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              const SharedFooter(),
            ],
          ),
        ],
      ),
    );
  }
}
