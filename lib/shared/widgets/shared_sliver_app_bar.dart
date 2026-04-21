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
      toolbarHeight: 72, // gives breathing space
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.go('/'),
                child: Opacity(
                  opacity: 0.95, // subtle premium feel
                  child: Image.asset(
                    'assets/images/studio/blackmoon_logo.png',
                    height: 48, // 🔥 controlled size (not width)
                    fit: BoxFit.contain,
                    color: Colors.white,
                  ),
                ),
              ),

              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.textPrimary,
                  size: 26,
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
