import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../layout/main_scaffold.dart';

class SharedSliverAppBar extends StatelessWidget {
  const SharedSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 90, // Match the previous header height
      flexibleSpace: ClipPath(
        clipper: NotchClipper(),
        child: Container(
          color: const Color(0xFF0B0F14), // Dark background for the header
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SafeArea(
                bottom: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: Image.asset(
                        'assets/images/studio/blackmoon_logo.png',
                        width: 120, // Min width 120px as per requirements
                        fit: BoxFit.contain,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: AppColors.textPrimary,
                        size: 28,
                      ),
                      onPressed: () {
                        // Access MainScaffold and toggle menu
                        MainScaffold.of(context)?.toggleMenu();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
