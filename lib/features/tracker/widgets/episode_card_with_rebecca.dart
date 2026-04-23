import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';

// Deep Dreadmoor Crimson Red
const Color _accentColor = Color(0xFFD32F2F); 

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
        // Episode Title
        Text(
          episode.title.toUpperCase(),
          style: AppTextStyles.h1.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        
        _buildBlackMoonTrack('STORY', episode.storyProgress),
        const SizedBox(height: 32),
        
        _buildBlackMoonTrack('PROGRAMMING', episode.programmingProgress),
        const SizedBox(height: 32),
        
        _buildBlackMoonTrack('ART & MEDIA', episode.artProgress),
        
        const SizedBox(height: 64), // Spacing at the bottom of the card
      ],
    );
  }

  // Sharp, glowing terminal-style tracker to replace the chunky Everbyte look
  Widget _buildBlackMoonTrack(String label, int percentage) {
    final double factor = (percentage / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              label,
              style: AppTextStyles.body.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              '$percentage%',
              style: AppTextStyles.body.copyWith(
                color: _accentColor,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace', 
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: 4, // Sharp, thin track instead of a chunky block
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(20), // Dim background track
            borderRadius: BorderRadius.zero, // Sharp edges
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: factor,
            child: Container(
              decoration: BoxDecoration(
                color: _accentColor,
                boxShadow: [
                  BoxShadow(
                    color: _accentColor.withAlpha(100),
                    blurRadius: 8, // Cinematic neon glow
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
