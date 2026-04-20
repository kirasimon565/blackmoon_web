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

    return Padding(
      padding: const EdgeInsets.only(bottom: 64),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.title.toUpperCase(),
              style: AppTextStyles.h1.copyWith(
                fontSize: screenWidth * 0.06 > 36.0
                    ? 36.0
                    : (screenWidth * 0.06 < 20.0 ? 20.0 : screenWidth * 0.06),
                fontWeight: FontWeight.w600, // Medium/Semi-bold
                letterSpacing: 0, // Normal tracking
                color: const Color(0xFFD0D4D8), // Slightly dimmed white
              ),
            ),
            const SizedBox(height: 24),
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
    );
  }
}
