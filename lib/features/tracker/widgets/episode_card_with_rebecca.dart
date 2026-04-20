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

    return Padding(
      padding: const EdgeInsets.only(bottom: 64),
      child: Padding(
        padding: EdgeInsets.only(right: isDesktop ? 200 : 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.title.toUpperCase(),
              style: AppTextStyles.h1.copyWith(
                fontSize: screenWidth * 0.08 > 48.0
                    ? 48.0
                    : (screenWidth * 0.08 < 24.0 ? 24.0 : screenWidth * 0.08),
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
                color: Colors.white,
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
    );
  }
}
