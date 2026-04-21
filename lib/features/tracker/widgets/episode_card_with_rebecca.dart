import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../models/episode_model.dart';

const Color _accentPink = Color(0xFFFF4D79);

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
        
        _buildEverbyteTrack('STORY', episode.storyProgress),
        const SizedBox(height: 32),
        
        _buildEverbyteTrack('PROGRAMMING', episode.programmingProgress),
        const SizedBox(height: 32),
        
        // Kept as "ART & MEDIA" to maintain BlackMoon's unique identity
        _buildEverbyteTrack('ART & MEDIA', episode.artProgress),
        
        const SizedBox(height: 64), // Spacing at the bottom of the card
      ],
    );
  }

  Widget _buildEverbyteTrack(String label, int percentage) {
    // Convert your integer percentage (0-100) to a fraction (0.0-1.0) for FractionallySizedBox
    final double factor = (percentage / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            color: _accentPink,
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
              color: _accentPink, // The filled part
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$percentage%',
                style: AppTextStyles.h1.copyWith(
                  color: Colors.white,
                  fontSize: 24,
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
