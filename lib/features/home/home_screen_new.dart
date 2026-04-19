import 'package:flutter/material.dart';
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

              // Hero Section - Asymmetrical, text offset
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 550,
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
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.black.withAlpha(220),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // L2: Content (Off-center, bottom-left aligned)
                      Positioned(
                        bottom: 64,
                        left: 24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "STUDIO",
                              style: AppTextStyles.bodySecondary.copyWith(
                                fontSize: 12, // Reduced
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'BLACKMOON',
                              style: AppTextStyles.h1.copyWith(
                                fontSize: 56, // Reduced
                                fontWeight: FontWeight.w900,
                                letterSpacing: -2,
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
                    _GameCard(
                      title: 'DREADMOOR',
                      imagePath:
                          'assets/images/backgrounds/dreadmoor_forest.png',
                      onTap: () {},
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
  final VoidCallback onTap;

  const _GameCard({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
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
                  color: Colors.black.withAlpha(80), // Subtle dark overlay
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: AppTextStyles.h1.copyWith(
                    fontSize: 40, // Reduced
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
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
