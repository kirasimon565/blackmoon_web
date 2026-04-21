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
      backgroundColor: Colors.black, // Dark background like Everbyte
      body: Stack(
        children: [
          // L0: Global Background
          Positioned.fill(
            child: Container(color: Colors.black),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.05),
              errorBuilder: (context, error, stackTrace) => const SizedBox(),
            ),
          ),

          // L1: Scroll
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SharedSliverAppBar(),

              // HERO SECTION
              // Keeping this so you still have a grand entrance to the studio site
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7, // Dynamic height
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/backgrounds/fog_main.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const SizedBox(),
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Colors.black.withAlpha(240),
                                Colors.black.withAlpha(50),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "STUDIO",
                                style: AppTextStyles.bodySecondary.copyWith(
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // GAME CARDS LIST
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _GameCard(
                      title: 'DREADMOOR',
                      imagePath: 'assets/images/backgrounds/dreadmoor_forest.png',
                      onTap: () {
                        context.go('/dreadmoor');
                      },
                    ),
                    // You can easily add more games here later
                    // _GameCard(
                    //   title: 'ITALIC',
                    //   imagePath: 'assets/images/backgrounds/italic_bg.png',
                    //   onTap: () {},
                    // ),
                  ]),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 64)),

              // THE WAVE TRANSITION (Matches Everbyte screenshot)
              const SliverToBoxAdapter(
                child: _FooterWave(),
              ),

              // THE FOOTER
              // Note: To match Everbyte perfectly, ensure your SharedFooter has a Colors.white background and black text/icons.
              const SharedFooter(),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// GAME CARD WIDGET
// ==========================================
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
    // Everbyte cards are very wide. 21/9 gives a great cinematic banner feel.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24), // The Everbyte rounded look
        child: AspectRatio(
          aspectRatio: 21 / 9, 
          child: Stack(
            children: [
              // 1. Background Image
              Positioned.fill(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF1A1A1A)),
                ),
              ),
              
              // 2. Subtle overlay so text remains readable
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withAlpha(180),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              
              // 3. Title (If you get custom logo images later, swap this Text for an Image.asset)
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
                      const Shadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
              
              // 4. Click Handler
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white.withAlpha(30),
                    highlightColor: Colors.white.withAlpha(10),
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

// ==========================================
// CUSTOM WAVE CLIPPER FOR FOOTER
// ==========================================
class _FooterWave extends StatelessWidget {
  const _FooterWave();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Height of the wave transition
      width: double.infinity,
      color: Colors.transparent,
      child: ClipPath(
        clipper: _WaveClipper(),
        child: Container(
          color: Colors.white, // This ensures a seamless transition into a white footer
        ),
      ),
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // Start at bottom left
    path.moveTo(0, size.height);
    
    // Go up the left side, but leave some black space
    path.lineTo(0, size.height * 0.8);
    
    // Swoop up to the top right corner
    path.quadraticBezierTo(
      size.width * 0.4, size.height * 0.9, 
      size.width, 0
    );
    
    // Go down the right side
    path.lineTo(size.width, size.height);
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
