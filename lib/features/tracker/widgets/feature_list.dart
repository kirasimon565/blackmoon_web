import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

// Matching your studio palette
const Color _accentPink = Color(0xFFFF4D79);
const Color _accentOrange = Color(0xFFF2A679);

class FeatureList extends StatelessWidget {
  final List<String> completed;
  final List<String> inProgress;
  final List<String> planned;

  const FeatureList({
    super.key,
    required this.completed,
    required this.inProgress,
    required this.planned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(5), // Very subtle dark tile feel
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (completed.isNotEmpty) ...[
            _buildCategory('MODULES DEPLOYED', completed, _accentPink),
            const SizedBox(height: 24),
          ],
          if (inProgress.isNotEmpty) ...[
            _buildCategory('CURRENTLY PROCESSING', inProgress, _accentOrange),
            const SizedBox(height: 24),
          ],
          if (planned.isNotEmpty) ...[
            _buildCategory('QUEUED / UPCOMING', planned, Colors.white38),
          ],
        ],
      ),
    );
  }

  Widget _buildCategory(String title, List<String> items, Color accentColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header
        Row(
          children: [
            Container(width: 4, height: 14, color: accentColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTextStyles.bodySecondary.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w900,
                fontSize: 12,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // List items
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sharp geometric bullet instead of standard circle
                  Text(
                    "> ",
                    style: TextStyle(
                      color: accentColor.withAlpha(150),
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.toUpperCase(), // Aggressive studio look
                      style: AppTextStyles.body.copyWith(
                        color: Colors.white,
                        fontSize: 14,
                        letterSpacing: 0.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
