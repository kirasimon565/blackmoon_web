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
              opacity: const AlwaysStoppedAnimation(0.08), // Slightly heavier noise for texture
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),

          // L1: CustomScrollView
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // SliverAppBar
              const SharedSliverAppBar(),

              // HERO SECTION
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background Image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/backgrounds/dreadmoor_forest.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter, // Focus on the trees
                        ),
                      ),
                      // Cinematic Bottom-Up Gradient
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                                AppColors.background, // Fades perfectly into the body
                              ],
                              stops: const [0.0, 0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "INTERACTIVE THRILLER // IN DEVELOPMENT",
                              style: AppTextStyles.bodySecondary.copyWith(
                                letterSpacing: 2,
                                fontWeight: FontWeight.w800,
                                color: AppColors.accentSecondary, // Orange warning color
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'DREADMOOR',
                              style: AppTextStyles.h1.copyWith(
                                fontSize: MediaQuery.of(context).size.width * 0.14 > 64.0 
                                    ? 64.0 
                                    : MediaQuery.of(context).size.width * 0.14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -1.5,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 16), // Space before it hits the bottom
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // SYNOPSIS / THE HOOK
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Every town has its secrets. Dreadmoor is built on them.",
                        style: AppTextStyles.h2.copyWith(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Rebecca Stone vanished without a trace. The local authorities have gone quiet, the townsfolk look the other way, and the shadows in the forest seem to be creeping closer to the edge of town.\n\nYou are the only one looking for her. But in Dreadmoor, digging up the truth usually means digging your own grave.",
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "Nothing's as it seems.",
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 48)),

              // ACTION BUTTONS (Sharp, BlackMoon Terminal Style)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      // PLAY NOW BUTTON (Solid Crimson)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.zero, // Razor sharp
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withAlpha(80),
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {}, // Add your play/download logic here
                            splashColor: Colors.black.withAlpha(50),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              child: Text(
                                'PLAY NOW',
                                style: AppTextStyles.body.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 2.0,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // TRACKER BUTTON (Hollow Outlined Crimson)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: AppColors.accent, width: 1.5),
                          borderRadius: BorderRadius.zero,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => context.go('/tracker'),
                            splashColor: AppColors.accent.withAlpha(30),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'VIEW TRACKER',
                                    style: AppTextStyles.body.copyWith(
                                      color: AppColors.accent,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.5,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.radar, // A cool terminal/tracking icon
                                    color: AppColors.accent,
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 80)),

              // Footer
              const SharedFooter(),
            ],
          ),
        ],
      ),
    );
  }
}
