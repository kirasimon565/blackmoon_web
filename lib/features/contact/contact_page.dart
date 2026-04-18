import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/layout/responsive_container.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Contact', style: AppTextStyles.h1),
            SizedBox(height: 16),
            Text(
              'For inquiries, reach out via email.',
              style: AppTextStyles.body,
            ),
            SizedBox(height: 32),
            Text(
              'Contact information will be available soon.',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
