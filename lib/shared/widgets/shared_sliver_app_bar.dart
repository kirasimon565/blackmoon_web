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
      backgroundColor: Colors.black.withAlpha(220), 
      elevation: 0,
      toolbarHeight: 90, 
      flexibleSpace: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          alignment: Alignment.center, // 🔥 THIS LOCKS EVERYTHING IN THE VERTICAL CENTER
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // THE LOGO
              GestureDetector(
                onTap: () => context.go('/'),
                child: Image.asset(
                  'assets/images/studio/blackmoon_logo.png',
                  height: 50, 
                  fit: BoxFit.contain,
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

              // THE MENU ICON
              IconButton(
                icon: const Icon(
                  Icons.menu_rounded, 
                  color: AppColors.accent, 
                  size: 25, 
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
