import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Make sure this is in your pubspec.yaml
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SharedFooter extends StatelessWidget {
  const SharedFooter({super.key});

  // Simple function to handle the external link
  Future<void> _launchFacebook() async {
    final Uri url = Uri.parse('https://www.facebook.com/blackmoonstudioofficial');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(
            top: BorderSide(color: AppColors.accent, width: 1), // Your sharp crimson/pink line
          ),
        ),
        padding: const EdgeInsets.only(top: 48, bottom: 48, left: 24, right: 24),
        child: Column(
          children: [
            // Row 1: Only Facebook Icon
            InkWell(
              onTap: _launchFacebook,
              borderRadius: BorderRadius.circular(30),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.facebook,
                  color: Colors.white,
                  size: 42, // Slightly larger for impact since it's alone
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Row 2: Clean Copyright notice
            Text(
              'BlackMoon Studio © 2026',
              style: AppTextStyles.bodySecondary.copyWith(
                color: Colors.white38, // Muted so it doesn't distract from the icon
                letterSpacing: 1.2,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
