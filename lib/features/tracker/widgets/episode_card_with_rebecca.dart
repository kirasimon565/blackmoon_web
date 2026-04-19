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
    return Padding(
      padding: const EdgeInsets.only(bottom: 48),
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
                        fontSize: MediaQuery.of(context).size.width * 0.08 > 48.0
                            ? 48.0
                            : (MediaQuery.of(context).size.width * 0.08 < 24.0 ? 24.0 : MediaQuery.of(context).size.width * 0.08),
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
    );
  }
}
