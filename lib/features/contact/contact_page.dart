import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/shared_sliver_app_bar.dart';
import '../../shared/widgets/shared_footer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: AppColors.background,
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.08),
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
                                AppColors.background,
                              ],
                              stops: const [0.0, 0.6, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SECURE CHANNELS",
                                style: AppTextStyles.bodySecondary.copyWith(
                                  letterSpacing: 4,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentSecondary, // Orange
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'CONTACT',
                                style: AppTextStyles.h1.copyWith(
                                  fontSize: MediaQuery.of(context).size.width * 0.12 > 72.0 
                                      ? 72.0 
                                      : (MediaQuery.of(context).size.width * 0.12 < 42.0 
                                          ? 42.0 
                                          : MediaQuery.of(context).size.width * 0.12),
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -2,
                                  height: 1.1,
                                ),
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

              // CONTENT SECTION (Terminal Style Box)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(5),
                      border: Border.all(color: AppColors.accent, width: 1.5), // Crimson frame
                    ),
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              color: AppColors.accent, // Blinking light vibe
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "SYSTEM STATUS: OFFLINE",
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.accent,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0,
                                fontSize: 14,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Direct communication protocols are currently secured and in active development.",
                          style: AppTextStyles.body.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Public contact information will be established prior to the launch of Episode 1. Until then, keep an eye on the official network.",
                          style: AppTextStyles.body.copyWith(
                            color: Colors.white70,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 100)),

              // Footer
              const SharedFooter(),
            ],
          ),
        ],
      ),
    );
  }
}
