import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_colors.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (completed.isNotEmpty) ...[
          _buildCategory('Completed', completed),
          const SizedBox(height: 16),
        ],
        if (inProgress.isNotEmpty) ...[
          _buildCategory('In Progress', inProgress),
          const SizedBox(height: 16),
        ],
        if (planned.isNotEmpty) ...[
          _buildCategory('Planned', planned),
        ],
      ],
    );
  }

  Widget _buildCategory(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.bodyMedium),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: TextStyle(color: AppColors.textSecondary)),
              Expanded(child: Text(item, style: AppTextStyles.body)),
            ],
          ),
        )),
      ],
    );
  }
}
