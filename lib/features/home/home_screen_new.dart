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
      backgroundColor: Colors.black, 
      body: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.black)),
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.08), // Slightly heavier noise
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SharedSliverAppBar(),
              
              // HERO SECTION
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 450, 
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/backgrounds/fog_main.png',
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(),
                        ),
                      ),
                      // Cinematic Bottom-Up Fade
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withAlpha(150),
                                Colors.black, // Fades perfectly into the background
                              ],
                              stops: const [0.0, 0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.bottomLeft, // Sits on the fade
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "STUDIO",
                                style: AppTextStyles.bodySecondary.copyWith(
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentSecondary, // Orange accent
                                ),
                              ),
                              const SizedBox(height: 8),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final width = constraints.maxWidth;
                                  double fontSize = width * 0.14;
                                  if (fontSize > 110) fontSize = 110;
                                  if (fontSize < 42) fontSize = 42;

                                  return Text(
                                    'BLACKMOON',
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.visible,
                                    style: AppTextStyles.h1.copyWith(
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: -2,
                                      height: 1.0,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // STUDIO HOOK
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "We build psychological thrillers and interactive mysteries.\n\nDive into deep narratives, uncover hidden truths, and explore worlds where your choices dictate the outcome.",
                        style: AppTextStyles.body.copyWith(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // GAME CARDS LIST
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      "ACTIVE PROJECTS",
                      style: AppTextStyles.bodySecondary.copyWith(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _GameCard(
                      title: 'DREADMOOR',
                      imagePath: 'assets/images/backgrounds/dreadmoor_forest.png',
                      onTap: () {
                        context.go('/dreadmoor');
                      },
                    ),
                  ]),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 64)),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white.withAlpha(20), width: 1), // Subtle frame
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.zero, // Razor sharp cinematic edges
          child: AspectRatio(
            aspectRatio: 21 / 9, 
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF1A1A1A)),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withAlpha(200),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: AppTextStyles.h1.copyWith(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Colors.white,
                      shadows: [
                        const Shadow(color: Colors.black, blurRadius: 20, offset: Offset(0, 4)),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: AppColors.accent.withAlpha(30), // Crimson splash
                      highlightColor: Colors.white.withAlpha(10),
                      onTap: onTap,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
