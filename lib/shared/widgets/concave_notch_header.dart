import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';

class ConcaveNotchHeader extends StatelessWidget {
  final VoidCallback onMenuToggle;
  final bool isMenuOpen;

  const ConcaveNotchHeader({
    super.key,
    required this.onMenuToggle,
    required this.isMenuOpen,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    final double logoHeight = isDesktop ? 80.0 : 64.0;
    final double headerHeight = isDesktop ? 100.0 : 84.0;

    return ClipPath(
      clipper: _ConcaveNotchClipper(),
      child: Container(
        color: AppColors.background,
        height: headerHeight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left: BLACKMOON (text logo or image logo based on previous code)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white.withAlpha(230),
                  BlendMode.srcATop,
                ),
                child: Image.asset(
                  'assets/images/studio/blackmoon_logo.png',
                  height: logoHeight,
                ),
              ),
            ),

            // Right: menu icon
            IconButton(
              icon: Icon(
                isMenuOpen ? Icons.close : Icons.menu,
                color: AppColors.textPrimary,
                size: 28,
              ),
              onPressed: onMenuToggle,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConcaveNotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Top-left
    path.lineTo(0, 0);
    // Bottom-left
    path.lineTo(0, size.height);

    // Bottom edge towards center notch
    final notchWidth = 160.0;
    final notchDepth = 20.0;
    final center = size.width / 2;

    path.lineTo(center - notchWidth / 2, size.height);

    // Quadratic bezier curve for the smooth concave notch
    path.quadraticBezierTo(
      center, size.height - notchDepth * 2, // Control point
      center + notchWidth / 2, size.height,   // End point
    );

    // Bottom-right
    path.lineTo(size.width, size.height);
    // Top-right
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
