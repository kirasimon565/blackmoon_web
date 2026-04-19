import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  static MainScaffoldState? of(BuildContext context) {
    return context.findAncestorStateOfType<MainScaffoldState>();
  }

  @override
  State<MainScaffold> createState() => MainScaffoldState();
}

class MainScaffoldState extends State<MainScaffold> {
  bool _isMenuOpen = false;

  void toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  void closeMenu() {
    if (_isMenuOpen) {
      setState(() => _isMenuOpen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Global Persistent Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/fog_main.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: AppColors.background),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: AppColors.background.withAlpha((0.85 * 255).toInt()),
            ),
          ),
          // Content
          widget.child,

          /// 🔥 FULL SCREEN MENU
          if (_isMenuOpen)
            Positioned.fill(
              child: _OverlayMenu(onClose: closeMenu),
            ),
        ],
      ),
    );
  }
}

class _OverlayMenu extends StatelessWidget {
  final VoidCallback onClose;

  const _OverlayMenu({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _menuItem(context, "Home", "/"),
              const SizedBox(height: 32),
              _menuItem(context, "Dreadmoor", "/dreadmoor"),
              const SizedBox(height: 32),
              _menuItem(context, "Episode Tracker", "/tracker"),
              const SizedBox(height: 32),
              _menuItem(context, "Contact", "/contact"),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ FIXED MENU ITEM (NO copyWith nonsense)
  Widget _menuItem(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        onClose();
        context.go(route);
      },
      child: Text(
        title,
        style: AppTextStyles.h1.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
