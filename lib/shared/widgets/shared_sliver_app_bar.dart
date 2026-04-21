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
      toolbarHeight: 72, // balanced height
      flexibleSpace: Container(
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
                  offset: const Offset(0, 4), // 🔥 fixes "too high" feeling
                  child: Image.asset(
                    'assets/images/studio/blackmoon_logo.png',
                    height: 58, // 🔥 correct visual size
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
