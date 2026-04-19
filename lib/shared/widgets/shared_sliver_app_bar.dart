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
      flexibleSpace: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => context.go('/'),
                child: Image.asset(
                  'assets/images/studio/blackmoon_logo.png',
                  width: 120, // minimum 120px
                  fit: BoxFit.contain,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.textPrimary,
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
