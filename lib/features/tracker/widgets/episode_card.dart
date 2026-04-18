import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';
import 'progress_bar.dart';
import 'feature_list.dart';

class EpisodeCard extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeCard({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.trackerBackground, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(episode.title, style: AppTextStyles.h2),
              Text(
                'Status: ${episode.status}',
                style: AppTextStyles.bodySecondary.copyWith(
                  color: episode.status == 'Released' ? Colors.greenAccent : AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Progress', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 16),
          ProgressBar(label: 'Story', percentage: episode.storyProgress),
          ProgressBar(label: 'Programming', percentage: episode.programmingProgress),
          ProgressBar(label: 'Art & Media', percentage: episode.artProgress),
          const SizedBox(height: 32),
          const Text('Features', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 16),
          FeatureList(
            completed: episode.completedFeatures,
            inProgress: episode.inProgressFeatures,
            planned: episode.plannedFeatures,
          ),
        ],
      ),
    );
  }
}
