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
          
          // Main Content
          widget.child,

          // Invisible overlay to close the menu when clicking outside of it
          if (_isMenuOpen)
            Positioned.fill(
              child: GestureDetector(
                onTap: closeMenu,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.black.withAlpha(120), // Subtle dimming effect
                ),
              ),
            ),

          // 🔥 FLOATING MINIMAL MENU
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            // Slides down from 60 to 85 when opened
            top: _isMenuOpen ? 85.0 : 60.0, 
            right: 24.0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              // Fades in and out
              opacity: _isMenuOpen ? 1.0 : 0.0, 
              child: IgnorePointer(
                ignoring: !_isMenuOpen, // Prevents clicks when closed/invisible
                child: _FloatingMenuPanel(onClose: closeMenu),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// THE FLOATING PANEL DESIGN
// ==========================================
class _FloatingMenuPanel extends StatelessWidget {
  final VoidCallback onClose;

  const _FloatingMenuPanel({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0C10).withAlpha(250), // Very deep black glass
        borderRadius: BorderRadius.circular(8), // Sharp, clean corners
        border: Border.all(color: Colors.white.withAlpha(15)), // Barely visible stroke
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(150),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end, // Aligns text to the right, under the hamburger
        children: [
          _MinimalNavItem(title: "HOME", route: "/", onClose: onClose),
          const SizedBox(height: 24),
          _MinimalNavItem(title: "DREADMOOR", route: "/dreadmoor", onClose: onClose),
          const SizedBox(height: 24),
          _MinimalNavItem(title: "TRACKER", route: "/tracker", onClose: onClose),
          const SizedBox(height: 24),
          _MinimalNavItem(title: "CONTACT", route: "/contact", onClose: onClose),
        ],
      ),
    );
  }
}

// ==========================================
// MINIMAL NAV ITEM INTERACTION
// ==========================================
class _MinimalNavItem extends StatefulWidget {
  final String title;
  final String route;
  final VoidCallback onClose;

  const _MinimalNavItem({
    required this.title,
    required this.route,
    required this.onClose,
  });

  @override
  State<_MinimalNavItem> createState() => _MinimalNavItemState();
}

class _MinimalNavItemState extends State<_MinimalNavItem> {
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          // Slides slightly to the left on hover/tap since it's right-aligned
          transform: Matrix4.translationValues(_isHovered ? -4.0 : 0.0, 0, 0),
          child: Text(
            widget.title,
            style: AppTextStyles.body.copyWith(
              fontSize: 16, 
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
              color: _isHovered ? AppColors.accent : Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
