import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SharedFooter extends StatelessWidget {
  const SharedFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.black, // Dark footer
          border: Border(
            top: BorderSide(color: AppColors.accent, width: 1), // Sharp pink separator
          ),
        ),
        padding: const EdgeInsets.only(top: 32, bottom: 64, left: 24, right: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(Icons.facebook),
                const SizedBox(width: 32),
                _customTextIcon('X'), 
                const SizedBox(width: 32),
                _socialIcon(Icons.camera_alt_outlined), 
              ],
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 12,
              children: [
                _footerLink('Home'),
                _separator(),
                _footerLink('Imprint & Privacy Policy'),
                _separator(),
                _footerLink('Press'),
              ],
            ),
            const SizedBox(height: 12),
            _footerLink('Contact'),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return InkWell(
      onTap: () {},
      child: Icon(icon, color: Colors.white, size: 36), // White icons
    );
  }

  Widget _customTextIcon(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // White text icon
          fontSize: 34,
          fontWeight: FontWeight.w300, 
          fontFamily: 'monospace', 
          height: 1.0,
        ),
      ),
    );
  }

  Widget _footerLink(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.white70, // Slightly muted white for links
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _separator() {
    return Text(
      '|',
      style: AppTextStyles.body.copyWith(
        color: AppColors.accent, // Pink pipeline separators
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
