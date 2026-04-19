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
                              "CURRENT PROJECT",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySecondary.copyWith(
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold,
                                color: AppColors.accent,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'DREADMOOR',
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

              // Items Section (Buttons/Actions) - Keeping it raw and minimal
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48, vertical: 20),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(4), // Sharp, less UI-like
                          ),
                        ),
                        child: const Text(
                          'PLAY NOW',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      OutlinedButton(
                        onPressed: () => context.go('/tracker'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          foregroundColor: Colors.white,
                          side:
                              const BorderSide(color: Colors.white24, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'TRACKER',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
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
