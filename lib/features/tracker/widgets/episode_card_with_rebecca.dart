import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';

// Changed from Everbyte Pink to a deep Dreadmoor Crimson Red
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
        // If you want to show the Episode Title above the bars:
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

  Widget _buildBlackMoonTrack(String label, int percentage) {
    // Convert your integer percentage (0-100) to a fraction (0.0-1.0) for FractionallySizedBox
    final double factor = (percentage / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: _accentColor, // Updated to Crimson
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 4.0,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15), // Dim grey background track
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: factor,
            child: Container(
              color: _accentColor, // Updated to Crimson
              alignment: Alignment.centerRight,
              // Reduced padding so the text has more room in small bars
              padding: const EdgeInsets.symmetric(horizontal: 8), 
              child: Text(
                '$percentage%',
                maxLines: 1, // Forces the text to stay on a single line
                softWrap: false, // Prevents the % from dropping down
                style: AppTextStyles.h1.copyWith(
                  color: Colors.white,
                  fontSize: 18, // Reduced from 24 to fit better
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
