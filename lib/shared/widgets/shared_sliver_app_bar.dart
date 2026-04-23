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
      toolbarHeight: 72, 
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
                child: Transform.translate(
                  offset: const Offset(0, 0), 
                  child: Image.asset(
                    'assets/images/studio/blackmoon_logo.png',
                    height: 36, 
                    fit: BoxFit.contain,
                    color: Colors.white, // Back to white for the dark header
                    errorBuilder: (context, error, stackTrace) => const Text(
                      "BLACKMOON",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        letterSpacing: -1.0,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.accent, // BlackMoon Pink
                  size: 32, 
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
