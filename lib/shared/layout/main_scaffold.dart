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
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Deep Black Cinematic Background (No more blue!)
          Positioned.fill(
            child: Container(color: Colors.black.withAlpha(245)),
          ),
          // Heavier Noise Texture
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgrounds/noise_texture.png',
              fit: BoxFit.cover,
              opacity: const AlwaysStoppedAnimation(0.12),
            ),
          ),
          // Top Bar (Logo and Close Button)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/studio/blackmoon_logo.png',
                      height: 60, // Matched height with the app bar
                      fit: BoxFit.contain,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.textPrimary,
                        size: 38, // Matching menu icon size
                      ),
                      onPressed: onClose,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Center Column (Cinematic Nav Items)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NavItem(title: "HOME", route: "/", onClose: onClose),
                  const SizedBox(height: 32),
                  _NavItem(title: "DREADMOOR", route: "/dreadmoor", onClose: onClose),
                  const SizedBox(height: 32),
                  _NavItem(title: "EPISODE TRACKER", route: "/tracker", onClose: onClose),
                  const SizedBox(height: 32),
                  _NavItem(title: "CONTACT", route: "/contact", onClose: onClose),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String title;
  final String route;
  final VoidCallback onClose;

  const _NavItem({
    required this.title,
    required this.route,
    required this.onClose,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        onTap: () {
          widget.onClose();
          context.go(widget.route);
        },
        // Cinematic slide-and-color effect
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(_isHovered ? 15.0 : 0.0, 0, 0),
          child: Text(
            widget.title,
            style: AppTextStyles.h1.copyWith(
              fontSize: 42, // Heavy, large font
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: _isHovered ? AppColors.accent : Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}
