import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';
import 'progress_bar.dart';

class EpisodeCardWithRebecca extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeCardWithRebecca({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;
    final double imageOpacity = isDesktop ? 0.30 : 0.15;

    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
      child: Stack(
        children: [
          // Background Rebecca visual positioned to the right
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: screenWidth * 0.4,
            child: Opacity(
              opacity: imageOpacity,
              child: Image.asset(
                'assets/images/characters/rebecca_symbol_base.png',
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
          ),
          // Gradient overlay to blend Rebecca into the left background (#0B0F14)
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: screenWidth * 0.4,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.transparent,
                    Color(0xFF0B0F14), // AppColors.background
                  ],
                ),
              ),
            ),
          ),
          // Foreground Content, padded on the right to avoid overlapping the face
          Padding(
            padding: EdgeInsets.only(right: isDesktop ? 200 : 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster-style title header
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            color: const Color(0xFF11161D), // Dark surface
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withAlpha(50), // Very light black overlay
                          ),
                        ),
                        Center(
                          child: Text(
                            episode.title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h1.copyWith(
                              fontSize: screenWidth * 0.08 > 48.0
                                  ? 48.0
                                  : (screenWidth * 0.08 < 24.0 ? 24.0 : screenWidth * 0.08),
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ProgressBar(
                  label: 'Story',
                  percentage: episode.storyProgress,
                ),
                const SizedBox(height: 24),
                ProgressBar(
                  label: 'Programming',
                  percentage: episode.programmingProgress,
                ),
                const SizedBox(height: 24),
                ProgressBar(
                  label: 'Art & Media',
                  percentage: episode.artProgress,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
