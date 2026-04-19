import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background dark surface
            Positioned.fill(
              child: Container(
                color: AppColors.backgroundSecondary,
              ),
            ),

            // Optional character image
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Opacity(
                    opacity: 0.35,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        'assets/images/characters/rebecca_half.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Very light black overlay for readability
            Positioned.fill(
              child: Container(
                color: Colors.black.withAlpha(50),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      episode.title,
                      style: AppTextStyles.h2.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ProgressBar(
                    label: 'Story',
                    percentage: episode.storyProgress,
                  ),
                  const SizedBox(height: 16),
                  ProgressBar(
                    label: 'Programming',
                    percentage: episode.programmingProgress,
                  ),
                  const SizedBox(height: 16),
                  ProgressBar(
                    label: 'Art & Media',
                    percentage: episode.artProgress,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
