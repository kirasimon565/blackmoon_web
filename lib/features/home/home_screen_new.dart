import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/shared_sliver_app_bar.dart';
import '../../shared/widgets/shared_footer.dart';

class HomeScreenNew extends StatelessWidget {
  const HomeScreenNew({super.key});

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
              // SliverAppBar (Notch lives here)
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
                          'assets/images/backgrounds/fog_main.png',
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
                                Colors.black.withAlpha(220),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // L2: Content (Centered column)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "STUDIO",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySecondary.copyWith(
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'BLACKMOON',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.h1.copyWith(
                                fontSize: MediaQuery.of(context).size.width * 0.12 > 72.0
                                  ? 72.0
                                  : (MediaQuery.of(context).size.width * 0.12 < 32.0 ? 32.0 : MediaQuery.of(context).size.width * 0.12),
                                fontWeight: FontWeight.w900,
                                letterSpacing: -2,
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 48)),

              // Portfolio Items (Games)
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    GestureDetector(
                      onTap: () {
                        context.go('/dreadmoor');
                      },
                      child: const _GameCard(
                        title: 'DREADMOOR',
                        imagePath:
                            'assets/images/backgrounds/dreadmoor_forest.png',
                      ),
                    ),
                  ]),
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

class _GameCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const _GameCard({
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha(50), // Very light black overlay
                ),
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h1.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.08 > 48.0
                        ? 48.0
                        : (MediaQuery.of(context).size.width * 0.08 < 24.0 ? 24.0 : MediaQuery.of(context).size.width * 0.08),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
