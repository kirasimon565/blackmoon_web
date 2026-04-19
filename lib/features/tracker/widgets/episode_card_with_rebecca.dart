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
    final bool isReleased = episode.released;
    final String statusText = isReleased ? 'Released' : 'In Progress';

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(20)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Rebecca image
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Opacity(
              opacity: 0.25,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/characters/rebecca_half.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback empty space if image is not yet available
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      episode.title,
                      style: AppTextStyles.h2,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isReleased ? AppColors.accent.withAlpha(50) : AppColors.background,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: isReleased ? AppColors.accent : AppColors.textSecondary.withAlpha(100),
                        ),
                      ),
                      child: Text(
                        statusText,
                        style: AppTextStyles.bodySecondary.copyWith(
                          color: isReleased ? AppColors.accent : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 500, // Limit width of progress bars so they don't overlap the right side completely
                  child: Column(
                    children: [
                      ProgressBar(label: 'Story', percentage: episode.storyProgress),
                      const SizedBox(height: 16),
                      ProgressBar(label: 'Programming', percentage: episode.programmingProgress),
                      const SizedBox(height: 16),
                      ProgressBar(label: 'Art & Media', percentage: episode.artProgress),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
