import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';

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
    return ClipPath(
      clipper: NotchClipper(),
      child: Container(
        height: 90,
        color: const Color(0xFF0B0F14),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => context.go('/'),
              child: Image.asset(
                'assets/images/studio/blackmoon_logo.png',
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
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

class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 28);

    path.quadraticBezierTo(
      size.width / 2,
      size.height + 55,
      size.width,
      size.height - 28,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
