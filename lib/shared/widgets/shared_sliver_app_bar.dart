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
      backgroundColor: Colors.black.withAlpha(220), // Translucent black glass
      elevation: 0,
      toolbarHeight: 90, // Increased height to give the logo room to breathe
      flexibleSpace: Container(
        color: Colors.transparent, 
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => context.go('/'),
                child: Image.asset(
                  'assets/images/studio/blackmoon_logo.png',
                  height: 60, // Much bigger, making the moon & clouds visible
                  fit: BoxFit.contain,
                  // NOTE: I removed the color override so your true logo shows up!
                  errorBuilder: (context, error, stackTrace) => const Text(
                    "BLACKMOON",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 28,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.menu_rounded, // Slightly softer, thicker menu icon
                  color: AppColors.accent, // BlackMoon Crimson/Pink
                  size: 38, // Bigger touch target
                ),
                onPressed: () {
                  MainScaffold.of(context)?.toggleMenu();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
