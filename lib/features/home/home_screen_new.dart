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
            child: Container(color: AppColors.background),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.05),
              errorBuilder: (context, error, stackTrace) =>
                  const SizedBox(),
            ),
          ),

          // L1: Scroll
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SharedSliverAppBar(),

              // HERO
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 450,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      // Background
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/backgrounds/fog_main.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Stronger gradient
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.black.withAlpha(240),
                                Colors.black.withAlpha(0),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // CONTENT (LEFT ALIGNED — cinematic)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                "STUDIO",
                                style: AppTextStyles.bodySecondary.copyWith(
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // FIXED TITLE
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
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 48)),

              // GAME CARD
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _GameCard(
                      title: 'DREADMOOR',
                      imagePath:
                          'assets/images/backgrounds/dreadmoor_forest.png',
                      onTap: () {
                        context.go('/dreadmoor');
                      },
                    ),
                  ]),
                ),
              ),

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
    final width = MediaQuery.of(context).size.width;

    double fontSize = width * 0.08;
    if (fontSize > 48) fontSize = 48;
    if (fontSize < 24) fontSize = 24;

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
                  color: Colors.black.withAlpha(50),
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: AppTextStyles.h1.copyWith(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(onTap: onTap),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
