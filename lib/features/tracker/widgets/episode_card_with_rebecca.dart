import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';

class EpisodeCardWithRebecca extends StatelessWidget {
  final EpisodeModel episode;

  const EpisodeCardWithRebecca({
    super.key,
    required this.episode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          episode.title,
          style: AppTextStyles.h1.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 24),
        _buildEverbyteTrack('Story', episode.storyProgress),
        const SizedBox(height: 16),
        _buildEverbyteTrack('Programming', episode.programmingProgress),
        const SizedBox(height: 16),
        _buildEverbyteTrack('Art & Media', episode.artProgress),
      ],
    );
  }

  Widget _buildEverbyteTrack(String label, int percentage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(26), // ~0.1 opacity
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  height: 2,
                  width: constraints.maxWidth * (percentage / 100),
                  decoration: BoxDecoration(
                    color: const Color(0xFF50B5D8),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF50B5D8)
                            .withAlpha(102), // ~0.4 opacity
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
