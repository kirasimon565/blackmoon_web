import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

class SharedFooter extends StatelessWidget {
  const SharedFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white, // This completes the illusion with the _FooterWave
        padding: const EdgeInsets.only(top: 16, bottom: 64, left: 24, right: 24),
        child: Column(
          children: [
            // Row 1: Big, bold social icons (Black on White)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialIcon(Icons.facebook),
                const SizedBox(width: 32),
                _customTextIcon('X'), // Custom 'X' since it's not a standard Material Icon
                const SizedBox(width: 32),
                _socialIcon(Icons.camera_alt_outlined), // Closest native icon to Instagram
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Row 2: Pipeline separated links
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
            
            // Row 3: Contact
            _footerLink('Contact'),
          ],
        ),
      ),
    );
  }

  // Large, high-contrast black icons
  Widget _socialIcon(IconData icon) {
    return InkWell(
      onTap: () {},
      child: Icon(
        icon,
        color: Colors.black,
        size: 36,
      ),
    );
  }

  // Custom text widget to mimic the "X" logo
  Widget _customTextIcon(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 34,
          fontWeight: FontWeight.w300, 
          fontFamily: 'monospace', // Gives it that sharp, structural look
          height: 1.0,
        ),
      ),
    );
  }

  // Bold black links
  Widget _footerLink(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: AppTextStyles.body.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // The pipeline separator
  Widget _separator() {
    return Text(
      '|',
      style: AppTextStyles.body.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
